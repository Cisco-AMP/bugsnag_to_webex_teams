# README

A simple Ruby on Rails app that works as a WebEx bot.
It receives Webhooks from BugSnag and publishes a formatted Markdown
message into WebEx Teams.

```
https://<app-domain>/bugsnag_errors?room_id=<WebEx room ID where the bot
has access>
```

```bash
$ bundle
$ WEBEX_ACCESS_CODE=<your bot's WebEx access code> bin/rails s
```
