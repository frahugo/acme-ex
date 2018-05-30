# Magasin - CivilCode's Reference Application and Guides

[New Module](https://github.com/civilcode/magasin/issues/new?template=module.md) |
[New Ability](https://github.com/civilcode/magasin/issues/new?template=ability.md) |
[New Task](https://github.com/civilcode/magasin/issues/new?template=task.md) |
[New Bug](https://github.com/civilcode/magasin/issues/new?template=bug.md)

## About Magasin

Magasin is CivilCode's reference application and [development guides](./guides). It demonstrates
how we develop Elixir and Phoenix applications using an opinionated approach influenced by
[Domain-Driven Design](https://en.wikipedia.org/wiki/Domain-driven_design).

The application implements a basic ordering system.

## Technical Overview

* implemented as an Elixir umbrella application
* with a Phoenix HTML interface
* deployed on [Heroku](https://magasin-platform.herokuapp.com) with [Docker](https://www.docker.com)
* persists data in [PostgreSQL](https://www.postgresql.org) RDBMS
* an open source application with the source code hosted on [GitHub](https://github.com/civilcode/magasin)

## Development Setup

TBD

## Running tests

TBD

## Deployment

TBD

## Docker
### Locally
```
 docker-compose build
 docker-compose run application mix ecto.create
 docker-compose run application mix ecto.migrate
 docker-compose up -d
 docker-compose run application mix test
 docker-compose run -e MIX_ENV=test application mix ecto.migrate
```

### Reproduce production environment locally
```
# Build from the production Dockerfile and run
 docker build --no-cache -t magasin/app -f Dockerfile .
 docker run -i --name mag1 -t --rm -p 4000:4000 -e DATABASE_URL="postgres://user:password@hostname:5432/db" magasin/app /app/bin/magasin foreground

# Stop/ remove
 docker stop mag1
 docker container rm mag1

# Connect to a running container
docker exec -it mag1 bash

```

## About CivilCode Inc

[CivilCode Inc.](http://www.civilcode.io) develops tailored business applications in [Elixir](http://elixir-lang.org/) and [Phoenix](http://www.phoenixframework.org/)
in Montreal, Canada.
