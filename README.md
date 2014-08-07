# putio-rb [![Build Status](https://travis-ci.org/hubb/putio.rb.svg?branch=master)](https://travis-ci.org/hubb/putio.rb)

A wrapper around [put.io](https://put.io) api v2 which allows you to access all
your files and transfers.

## Install

    gem install putio-rb

## Usage

```
require 'putio-rb'

Putio.configure do |config|
  config.oauth_token = 'TOKEN' # mandatory
end
=> true

## Files
# list all files
client.files

```

## Todo

- [ ] list transfers
- [ ] add a transfer

## License

MIT
