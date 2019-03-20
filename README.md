# Rails TMDB

## Docker run
development:
```
$ docker-compose -f docker-compose.local.yml up
```
production:
```
$ docker-compose up
```

## Requirement
MySQL encoding: utf8mb4

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
