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
# also aliased as files
client.files

# list all transfers
client.list_transfers
# also aliased as transfers
client.transfers


```

## Todo

- [ ] find a file
- [ ] find a transfer
- [ ] add a transfer
- [ ] add a file

## License

See [LICENSE](https://github.com/hubb/putio.rb/blob/master/LICENSE.md)
