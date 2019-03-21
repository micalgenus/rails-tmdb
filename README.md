# Rails TMDB

## Requirement
MySQL encoding: utf8mb4

## Docker run
development:
```
$ docker-compose -f docker-compose.local.yml up
```

production:
```
$ docker-compose up
```

## Runner
### Search (movies and tvs)
```
$ rake crawler:search[:keyword]
```

example:
```
$ rake crawler:search[simpson]
```

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