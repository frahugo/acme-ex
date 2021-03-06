# Configuration

WEB_APP := magasin_web

# Targets

build: docker.stop docker.port.review docker.down docker.build docker.start app.setup db.setup
start: docker.start
stop: docker.stop

app.setup:
	docker-compose exec application mix deps.get
	docker-compose exec application sh -c 'cd /app/apps/$(WEB_APP)/assets/ && npm install'

app.docs:
	docker-compose exec application mix docs
	docker-compose exec application cp GLOSSARY.md apps/$(WEB_APP)/priv/static/
	docker-compose exec application cp -R doc apps/$(WEB_APP)/priv/static/

app.observe:
	open -a xquartz
	docker-compose exec -e DISPLAY=host.docker.internal:0 erlang erl -sname observer -hidden -setcookie secret -run observer

app.config:
	cp config/dev.secret.exs.sample config/dev.secret.exs
	cp config/test.secret.exs.sample config/test.secret.exs
	cp env.sample .env

	echo "Please configure the 'secret' configuration files in ./config directory."

app.console:
	docker-compose exec application iex --name vm@127.0.0.1 --cookie secret --erl '-kernel inet_dist_listen_min 9001 inet_dist_listen_max 9001' -S mix phx.server

app.run:
	docker-compose exec application mix phx.server

db.setup:
	# TEST
	docker-compose exec -e MIX_ENV=test application mix ecto.drop
	docker-compose exec -e MIX_ENV=test application mix ecto.create
	docker-compose exec -e MIX_ENV=test application mix event_store.init
	docker-compose exec -e MIX_ENV=test application mix ecto.migrate
	# DEV
	docker-compose exec application mix project.setup

docker.build:
	docker-compose build --force-rm --no-cache

docker.reset: docker.stop docker.clean docker.start app.setup

docker.down:
	docker-compose down --volumes

docker.clean:
	docker-compose rm -v -f
	docker-compose down --volumes
	docker-sync clean

docker.start:
	docker-sync start
	docker-compose up --detach

docker.stop:
	docker-compose stop
	docker-sync stop

docker.restart: stop start

docker.port.forward:
	mutagen forward create --name=acmePlatform tcp:localhost:9001 docker://acme-platform_application_1:tcp:localhost:9001
	mutagen forward create --name=acmePlatform tcp:localhost:4369 docker://acme-platform_application_1:tcp:localhost:4369
	epmd -names

docker.port.forward.terminate:
	mutagen forward terminate acmePlatform

docker.port.review:
	echo "Please ensure no Docker containers are running with the same ports as this docker-compose.yml file:"
	docker ps
	read -p "Press any key to continue..."

docker.bash:
	docker-compose exec application bash

release.create:
	bin/release_create

demo.dump:
	docker-compose exec application mix demo.dump

demo.load:
	docker-compose exec application mix demo.load
