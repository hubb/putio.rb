# Putio.rb

Simple ruby wrapper for the Put.io API v2

## Installation

    gem install putio.rb

## Documentation

### Examples

    > require 'putio.rb'
    => true
    > client = PutIO::Client.new(oauth_token: "YOUR_TOKEN")
    => #<PutIO::Client:0x007fab23b8e568
    @connection=#<PutIO::Connection:0x007fab23b8e518>,
    @files=
      #<PutIO::Files:0x007fab23b8e338
      @client=#<PutIO::Client:0x007fab23b8e568 ...>,
      @list=[
        #<struct PutIO::File
          id=00000001,
          name="Holiday pictures",
          content_type="application/x-directory",
          created_at="2013-07-13T10:05:46",
          icon="https://put.io/images/file_types/folder.png",
          size=2753110824>,
        #<struct PutIO::File
          id=00000002,
          name="Holiday movie.mp4",
          content_type="video/mp4",
          created_at="2013-07-10T19:21:56",
          icon="https://put.io/thumbnails/random_hash.jpg",
          size=333116354>
      ]>,
      @oauth_token="MY_TOKEN">
    > client.files.list
    => [
        #<struct PutIO::File
          id=00000001,
          name="Holiday pictures",
          content_type="application/x-directory",
          created_at="2013-07-13T10:05:46",
          icon="https://put.io/images/file_types/folder.png",
          size=2753110824>,
        #<struct PutIO::File
          id=00000002,
          name="Holiday movie.mp4",
          content_type="video/mp4",
          created_at="2013-07-10T19:21:56",
          icon="https://put.io/thumbnails/random_hash.jpg",
          size=333116354>
      ]

## TODOS

```
  client.files.search
  client.files.upload
  client.files.download(id)
  client.files.delete(id)
  client.files.rename(id)
  client.files.move(id)

  client.files.folder
```
