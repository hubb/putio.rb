# putio-rb [![Build Status](https://travis-ci.org/hubb/putio.rb.svg?branch=master)](https://travis-ci.org/hubb/putio.rb)

A wrapper around [put.io](https://put.io) api v2 which allows you to access all
your files and transfers.

## Install

    gem install putio-rb

## Usage

First, you'll need to generate an access token, please see [the documentation](http://put.io/v2/docs/gettingstarted.html#authentication-and-access).

### Configuration

```
require 'putio-rb'

Putio.configure do |config|
  config.access_token = 'SECRET TOKEN' # mandatory
  config.api_endpoint = 'https://foo.bar'
  config.api_version  = 'v1'
  config.user_agent   = 'kthxbye'
end
```

### Files

```
# list all files
client.list_files
# also aliased as files
client.files
```

### Transfers

```
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
