# putio-rb [![Build Status](https://travis-ci.org/hubb/putio.rb.svg?branch=master)](https://travis-ci.org/hubb/putio.rb)

A wrapper around [put.io](https://put.io) api v2 which allows you to access all
your files and transfers.

## Install

    gem install putio-rb

## Usage

```
require 'putio-rb'

Putio.configure do |config|
  config.access_token = 'TOKEN' # mandatory
end

# list all files
client.list_files
# also aliased as list_files
client.files

# list all transfers
client.transfers

```

## Todo

- [x] list transfers
- [ ] add a transfer

## License

MIT
