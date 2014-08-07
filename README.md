# putio-rb

A wrapper around [put.io](https://put.io) api v2 which allows you to access all
your files and transfers.

## Install

    gem install putio-rb

## Usage

```
require 'putio-rb'

client = Putio.new(auth_token: 'TOKEN')
=> #<Putio:0x007fab23b8e568 @client=#<Putio::CLient:0x007fab23b8e518>>

# Transfers
# list all transfers
client.transfers

# add a new transfer
client.add_transfer(url: 'url (torrent, magnet)')

## Files
# list all files
client.files

# upload a file
client.add_file(file: 'file (File)''
```

## License

MIT
