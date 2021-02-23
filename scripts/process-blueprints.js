/*
 * Copyright 2017 balena.io
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *    http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

"use strict";

const _ = require("lodash");
const fs = require("fs-extra");
const path = require("path");
const contrato = require("@balena/contrato");
const yaml = require("js-yaml");

const DEST_DIR = path.join(__dirname, "../output");
const CONTRACTS_PATH = path.join(__dirname, "../contracts");

const BLUEPRINT_PATHS = {
  instructions: path.join(__dirname, "../blueprints/instructions.yaml"),
  configuration: path.join(__dirname, "../blueprints/configuration.yaml"),
  initialization: path.join(__dirname, "../blueprints/initialization.yaml"),
  "hostapp-releases": path.join(
    __dirname,
    "../blueprints/hostapp-releases.yaml"
  ),
  hostapps: path.join(__dirname, "../blueprints/hostapps.yaml"),
};

// Find and build all contracts from the contracts/ directory
const allContracts = require("require-all")({
  dirname: CONTRACTS_PATH,
  filter: /.json$/,
  recursive: true,
  resolve: (json) => {
    return contrato.Contract.build(json);
  },
});

const contracts = _.reduce(
  _.values(allContracts),
  (accumulator, value) => {
    return _.concat(
      accumulator,
      _.flattenDeep(_.map(_.values(value), _.values))
    );
  },
  []
);

// Create universe of contracts
const universe = new contrato.Contract({
  type: "meta.universe",
});
universe.addChildren(contracts);

// Load arguments
const types = process.argv.slice(2);
if (types.length === 0) {
  console.error(`Usage: ${process.argv[0]} ${process.argv[1]} <types...>`);
  process.exit(1);
}

let blueprints = types;

if (types.indexOf("all") > -1) {
  // Generate dockerfile for all blueprints
  blueprints = Object.keys(BLUEPRINT_PATHS);
}

for (const type of blueprints) {
  if (!BLUEPRINT_PATHS[type]) {
    console.error(`Blueprint for this type: ${type} is missing!`);
    process.exit(1);
  }

  const query = yaml.safeLoad(fs.readFileSync(BLUEPRINT_PATHS[type], "utf8"));
  const result = contrato.query(universe, query.selector, query.output);
  const template = query.output.template[0].data;

  // Write output
  for (const context of result) {
    const json = context.toJSON();
    const destination = path.join(DEST_DIR, json.path, query.output.filename);

    console.log(`Generating ${json.slug}`);
    fs.outputFileSync(
      destination,
      contrato.buildTemplate(template, context, {
        directory: CONTRACTS_PATH,
      })
    );
  }

  console.log(
    `Generated ${result.length} results out of ${
      universe.getChildren().length
    } contracts`
  );
  console.log(
    `Adding generated ${result.length} contracts back to the universe`
  );
}
