## sentinel-notify-slack

### Basics

This script is intended to be used as notification handler for
redis-sentinel. It will pass sentinel notifications to Slack channel
as specified in configuration.

### Prerequisites

1. Slack token created by adding custom integration at
   https://YOURSLACK.slack.com/apps/manage where *YOURSLACK* is your
   slack subdomain component. It might look like this:
   `https://mycompany.slack.com`

2. Ruby (tested on 2.4.0)
3. Bundler gem (`$ gem install bundler`)


### Setup

1. Install dependencies from Gemfile (`$ bundle install`)
2. Copy example config to `config.yml` (it's the location that shell wrapper expects) and setup token and slack channel

### Testing

You can test this script by calling it directly and passing `-c
config.file` and two additional parameters - notification type and
notification content. E.g:

```
./sentinel-notify-slack -c test.yml -- '-odown' 'master mymaster 127.0.0.1 6379'
```


### Running from redis-sentinel

There's additional shell script intended to be used by *redis-sentinel*. (`shell_wrapper.sh`)

You can enable it by putting something like this in your `sentinel.conf`:

```
sentinel notification-script test /path/to/cloned/repo/shell_wrapper.sh
```

or at runtime from when connected to your sentinel via `redis-cli` by calling something like this:

```
$ redis-cli -p 26379
127.0.0.1:26379> sentinel set mymaster notification-script /path/to/cloned/repo/shell_wrapper.sh
```


### Author

Sławomir Kowalski (github.com/kowalskey)
