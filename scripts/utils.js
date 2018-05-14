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

const getAllFiles = dir =>
  fs.readdirSync(dir).reduce((files, file) => {
    const name = path.join(dir, file);
    const isDirectory = fs.statSync(name).isDirectory();
    return isDirectory ? [...files, ...getAllFiles(name)] : [...files, name];
  }, []);

exports.readContracts = (dir) => {
  const allFiles = getAllFiles(dir)
  let contracts = []

  allFiles.forEach((file) => {
    if (path.extname(file) == '.json') {
      contracts.push({
        type: path.basename(path.dirname(path.dirname(file))),
        source: require(file),
        path: file,
      })
    }
  })
  return contracts
}

exports.readSchemas = (dir) => {
  let schemas = {}

  fs.readdirSync(dir).forEach((file) => {
    schemas[path.basename(file, '.json')] = path.join(dir, file)
  })
  return schemas
}
