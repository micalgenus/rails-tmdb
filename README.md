# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

## Runner
### Search (movies)
```
$ rake crawler:movie[:keyword]
```

example:
```
$ rake crawler:movie[simpson]
```

### Search (tvs)
```
$ rake crawler:tv[:keyword]
```

example:
```
$ rake crawler:tv[simpson]
```
