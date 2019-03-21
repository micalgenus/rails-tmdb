# Rails TMDB

## Requirement
MySQL encoding: utf8mb4

.env:
```
MYSQL_HOST=mysql
MYSQL_USERNAME=mysql
MYSQL_PASSWORD=mysql
MYSQL_DATABASE=rails_tmdb

TMDBAPI_KEY=#{TMDB_API_KEY}
```

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