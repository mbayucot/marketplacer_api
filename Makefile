build:
	docker-compose build

rebuild:
	docker-compose up --build

start:
	docker-compose up

setup:
	docker-compose run web rails db:create db:migrate db:seed db:load_products

restart:
	docker-compose restart web

stop:
	docker-compose stop

rspec:
	docker exec -it marketplacer_api bash -c "bundle exec rspec"

login:
	docker exec -it marketplacer_api bash

postgres:
	docker exec -it marketplacer_postgres bash -c "psql marketplacer_api_development -U myuser"
