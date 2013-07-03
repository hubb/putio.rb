# Putio.rb

Simple ruby wrapper for the Put.io API

## Installation

    gem install putio.rb

## Documentation

### Examples

    client = PutIO::Client.new(token)


# Files

`client.files`

# list
# [parent_id]
def list
end

client.files.search
client.files.upload
client.files.download(id)
client.files.delete(id)
client.files.rename(id)
client.files.move(id)

client.files.folder

#

```