/*
 * Copyright 2017 resin.io
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

'use strict'

const path = require('path')
const utils = require('./utils')
const _ = require('lodash')
const Ajv = require('ajv')

const ajv = new Ajv({schemaId: 'auto'});
const CONTRACTS_PATH = path.join(__dirname, '..', 'contracts')
const SCHEMA_PATH = path.join(__dirname, '..', 'schema')
const schemas = utils.readSchemas(SCHEMA_PATH)
let success = true

for (const contract of utils.readContracts(CONTRACTS_PATH)) {

  if (contract.source.type !== contract.type) {
    success = false
    console.error(contract.path)
    console.error(`    The contract type is ${contract.source.type}, but it lives inside ${contract.type}`)
  }

  if (contract.source.type in schemas) {
    const valid = ajv.validate(require(schemas[contract.source.type]), contract.source)
    if (!valid) {
      success = false
      console.error(contract.path)
      console.error(ajv.errorsText())
    }
  }
}

if (!success) {
  process.exit(1)
}
