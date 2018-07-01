# Magasin - CivilCode's Reference Application and Guides

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

Before following the instructions below, ensure your development environment meets the prerequisites
outlined here:

    https://github.com/civilcode/playbook/blob/master/guides/ops/developer_setup.md

For a Docker-based development environment run the following setup scripts and follow
the instructions:

    git clone https://github.com/civilcode/magasin-platform
    cd magasin-platform    
    ./bin/setup.config
    ./bin/setup.docker

To run the server:

    docker-compose exec application mix phx.server

To view the application with your browser visit:

    http://localhost:4000

To start and shutdown Docker containers:

    docker-compose up -d
    docker-compose stop

## Guides

For more information on working with Docker for local development, deployment and other
application development guides visit:

    https://github.com/civilcode/magasin-platform/tree/master/guides/app

## About CivilCode Inc

[CivilCode Inc.](http://www.civilcode.io) develops tailored business applications in [Elixir](http://elixir-lang.org/) and [Phoenix](http://www.phoenixframework.org/)
in Montreal, Canada.
