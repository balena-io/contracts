import { expect } from './chai';
import * as path from 'path';
import { promises as fs } from 'fs';
import type { ContractObject } from '@balena/contrato';
import { Contract } from '@balena/contrato';

const CONTRACTS_PATH = path.join(__dirname, '..', 'contracts');

async function findFiles(
	dir: string,
	filter: (fileName: string, filePath: string) => boolean = () => true,
): Promise<string[]> {
	const dirFiles = await fs.readdir(dir);

	const filePaths: string[] = [];
	const dirPaths: string[] = [];
	for (const fileName of dirFiles) {
		const filePath = path.join(dir, fileName);

		const stat = await fs.stat(filePath);
		if (stat.isDirectory()) {
			dirPaths.push(filePath);
		} else if (filter(fileName, filePath)) {
			filePaths.push(filePath);
		}
	}

	const allFiles = await Promise.all(dirPaths.map((d) => findFiles(d, filter)));
	return filePaths.concat(...allFiles);
}

async function concurrentForEach<T>(
	it: IterableIterator<T>,
	fn: (t: T) => Promise<void>,
	concurrency = 1,
) {
	const run = async () => {
		const next = it.next();
		if (next.value && !next.done) {
			await fn(next.value);
			await run();
		}
	};
	const runs = [];
	for (let i = 0; i < concurrency; i++) {
		runs.push(run());
	}
	await Promise.all(runs);
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

	const meta: ContractMeta[] = [];
	await concurrentForEach(
		allFiles.values(),
		async (file) => {
			const contents = await fs.readFile(file, { encoding: 'utf8' });
			const source = JSON.parse(contents);
			meta.push({
				type: path.basename(path.dirname(path.dirname(file))),
				source,
				path: file,
			});
		},
		10,
	);

	return meta;
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

	it('the contract universe is internally consistent', function () {
		const allContracts = allContractsMeta
			.map(({ source }) => Contract.build(source))
			.flat();

		const universe = new Contract({ type: 'meta.universe' });
		universe.addChildren(allContracts);

		// The contracts universe is internally consistent
		// if all the children requirements are satisfied
		expect(universe.getAllNotSatisfiedChildRequirements()).to.equal([]);
		expect(universe.areChildrenSatisfied()).to.be.true;
	});
});
