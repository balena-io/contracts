import { expect } from './chai';
import * as path from 'path';
import { promises as fs } from 'fs';
import type { ContractObject } from '@balena/contrato';
import { Contract, Universe, query } from '@balena/contrato';

const CONTRACTS_PATH = path.join(__dirname, '..', 'contracts');

async function findFiles(
	dir: string,
	filter: (filePath: string) => boolean = () => true,
): Promise<string[]> {
	const allFiles = await fs.readdir(dir, { recursive: true });
	const filePaths: string[] = [];
	for (const fileName of allFiles) {
		const filePath = path.join(dir, fileName);
		const stat = await fs.stat(filePath);
		if (!stat.isDirectory() && filter(filePath)) {
			filePaths.push(filePath);
		}
	}

	return filePaths;
}

type ContractMeta = {
	type: string;
	source: ContractObject;
	path: string;
};

async function readContracts(dir: string): Promise<ContractMeta[]> {
	const allFiles = await findFiles(
		dir,
		(fileName) => path.extname(fileName) === '.json',
	);

	const { default: pMap } = await import('p-map');

	return (
		await pMap(
			allFiles.values(),
			async (file) => {
				const contents = await fs.readFile(file, { encoding: 'utf8' });
				const source = JSON.parse(contents);
				return {
					type: path.basename(path.dirname(path.dirname(file))),
					source,
					path: file,
				};
			},

			{ concurrency: 10 },
		)
	).flat();
}

describe('Balena Base Contracts', function () {
	let allContractsMeta: ContractMeta[];

	before(async () => {
		allContractsMeta = await readContracts(CONTRACTS_PATH);
	});

	it('contracts are stored in the right folder', function () {
		for (const contractMeta of allContractsMeta) {
			expect(
				contractMeta.source.type,
				`the contract type '${contractMeta.source.type}' does not match its parent folder '${contractMeta.type}'`,
			).to.equal(contractMeta.type);
		}
	});

	it('all children in the contract universe are satisfied', function () {
		const allContracts = allContractsMeta.flatMap(({ source }) =>
			Contract.build(source),
		);

		const universe = new Universe();
		universe.addChildren(allContracts);

		// The contracts universe is internally consistent
		// if all the children requirements are satisfied
		expect(universe.getAllNotSatisfiedChildRequirements()).to.deep.equal([]);
	});

	it('os/arch/device contract combinations are satisfied', function () {
		const allContracts = allContractsMeta.flatMap(({ source }) =>
			Contract.build(source),
		);

		const universe = new Universe();
		universe.addChildren(allContracts);

		const contexts = query(
			universe,
			{
				'sw.os': {
					cardinality: 1,
					filter: {
						type: 'object',
						properties: { slug: { not: { enum: ['balena-os', 'resinos'] } } },
					},
				},
				'arch.sw': 1,
				'sw.blob': '1+',
				'sw.stack-variant': 1,
				'hw.device-type': 1,
			},
			{ type: 'meta.context' },
		);

		for (const context of contexts) {
			const unmet = context.getAllNotSatisfiedChildRequirements();
			expect(
				unmet,
				'Unsatisfied requirements for context: ' +
					JSON.stringify(context, null, 2),
			).to.deep.equal([]);
		}
	});

	// Skipped as it takes too much time to calculate all combinations
	// TODO: unskip this once we can improve the efficiency
	// of contrato
	it.skip('os/arch/device/stack contract combinations are satisfied', function () {
		const allContracts = allContractsMeta.flatMap(({ source }) =>
			Contract.build(source),
		);

		const universe = new Universe();
		universe.addChildren(allContracts);

		const contexts = query(
			universe,
			{
				'sw.os': {
					cardinality: 1,
					filter: {
						type: 'object',
						properties: { slug: { not: { enum: ['balena-os', 'resinos'] } } },
					},
				},
				'arch.sw': 1,
				'sw.blob': '1+',
				'sw.stack': 1,
				'sw.stack-variant': 1,
				'hw.device-type': 1,
			},
			{ type: 'meta.context' },
		);

		for (const context of contexts) {
			const unmet = context.getAllNotSatisfiedChildRequirements();
			expect(
				unmet,
				'Unsatisfied requirements for context: ' +
					JSON.stringify(context, null, 2),
			).to.deep.equal([]);
		}
	});
});
