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
# list files in directory 123
client.files(options: { parent_id: 123 })
# search a file
client.search query: 'foo'
# complex search
client.search(query: 'jazz', options: { from: 'me,jack', ext: 'mp4', time: 'today' })
# find a file
client.file id: 123
# delete files 123 and 345
client.delete_files(123, 345)
```

### Transfers

```
# list all transfers
client.list_transfers
# also aliased as transfers
client.transfers
```

## Todo

### Files

- [x] list files
- [x] search files
- [ ] upload file
- [ ] create folder
- [x] get file
- [x] delete file
- [ ] rename file
- [ ] move file
- [ ] convert file to mp4
- [ ] get mp4 status
- [ ] download
- [ ] zip & download
- [ ] subtitles
- [ ] download subtitles

### Transfers

- [x] list transfers
- [ ] add transfer
- [ ] get transfer
- [ ] retry transfer
- [ ] cancel transfer
- [ ] clean transfers

### Friends

- [ ] list friends
- [ ] friend requests
- [ ] send request
- [ ] deny request

### Account

- [ ] info
- [ ] settings

## License

See [LICENSE](https://github.com/hubb/putio.rb/blob/master/LICENSE.md)
