# bte-trapi-workspace
A npm workspace setup for local development environment with all biothings explorer nodejs packages.

Modified from an example setup here: https://github.com/Quramy/npm-ts-workspaces-example

### Get started

Npm workspace feature requires npm 7+. It's recommended to use node v15+, which comes with npm v7.
You may consider using [nvm](https://github.com/nvm-sh/nvm#installing-and-updating) to install a newer version of node.

```
git clone git@github.com:biothings/bte-trapi-workspace.git
# use https is supported too
# git clone https://github.com/biothings/bte-trapi-workspace.git
# in this case, all package repos will be cloned using https as well.
cd bte-trapi-workspace

# setup local bte repos under packages folder
npm run clone

# install dependencies (including workspace interdependency)
npm i || true && npm i
```

### Start the development

* watch file changes and auto build code

  ```
  npm run watch
  ```

* start a dev server

  ```
  npm start
  ```
  or
  ```
  npm run debug --workspace=@biothings-explorer/bte-trapi
  ```

Now when you save your code change, the dev server should restart to reflect the latest change (after a few seconds).

### Developing with redis enabled

#### Easy Method:

* pull latest docker image
  ```
  docker pull redis:latest
  ```
* start server in debug mode with redis enabled:
  ```
  npm start redis
  ```

### Alternate method

* install redis

  macOS:
  ```
  brew install redis
  ```

* start redis

  macOS:
  ```
  brew services start redis
  ```
  linux:
  ```
  sudo service redis-server start
  ```

* start dev server with redis enabled

  ```
  REDIS_HOST=localhost REDIS_PORT=6379  REQUEST_TIMEOUT=1200 npm run debug --workspace=@biothings-explorer/bte-trapi
  ```
