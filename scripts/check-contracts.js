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

const utils = require('./utils')
const _ = require('lodash')

const requiredProps = ['slug', 'version', 'type', 'name', 'data', 'requires', 'variants']
let success = true

for (const contract of utils.readContracts()) {
  if (contract.source.slug !== contract.name) {
    success = false
    console.error(contract.path)
    console.error(`    The contract slug is ${contract.source.slug}, but the file name is ${contract.name}`)
  }

  if (contract.source.type !== contract.type) {
    success = false
    console.error(contract.path)
    console.error(`    The contract type is ${contract.source.type}, but it lives inside ${contract.type}`)
  }
  if ( ! _.every(requiredProps, _.partial(_.has, contract.source))) {
    success = false
    console.error(contract.path)
    console.error(`    Mandatory properties missing!`)
  }
}

if (!success) {
  process.exit(1)
}
