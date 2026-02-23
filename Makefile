-include .env
export
POSTGRES_USER ?= zipp
POSTGRES_DB ?= zipp_development

.PHONY: build run stop restart bundle logs ps clean migrate rollback

build:
	docker compose build

up:
	docker compose up -d

restart:
	docker compose down
	docker compose up -d

bundle:
	docker compose run --rm app bundle install

logs:
	docker compose logs -f $(service)

ps:
	docker compose ps

migrate:
	docker compose run --rm app bundle exec rake db:migrate

rollback:
	docker compose run --rm app bundle exec rake db:rollback

clean:
	docker compose down -v

console-app:
	docker compose run --rm app bundle exec bash

console-db:
	docker compose exec -it db psql -U $(POSTGRES_USER) -d $(POSTGRES_DB)

