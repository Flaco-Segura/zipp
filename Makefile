.PHONY: build run stop restart bundle logs ps clean migrate rollback

build:
	docker compose build

run:
	docker compose up -d

stop:
	docker compose down

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
