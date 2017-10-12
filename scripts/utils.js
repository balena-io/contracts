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

const fs = require('fs')
const path = require('path')
const CONTRACTS_PATH = path.join(__dirname, '..', 'contracts')
const TYPES = fs.readdirSync(CONTRACTS_PATH)

exports.readContracts = () => {
  return TYPES.reduce((accumulator, type) => {
    const typeDirectory = path.join(CONTRACTS_PATH, type)
    return accumulator.concat(fs.readdirSync(typeDirectory).map((fileName) => {
      const contractPath = path.join(CONTRACTS_PATH, type, fileName)

      let sourceObject = {}
      try {
        sourceObject = require(contractPath)
      } catch (error) {
        console.error(`Can't parse ${contractPath}`)
        process.exit(1)
      }

      return {
        type,
        source: sourceObject,
        path: contractPath,
        name: path.basename(fileName, '.json')
      }
    }))
  }, [])
}
