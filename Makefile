SHELL := /bin/bash # Use bash syntax
ARG := $(word 2, $(MAKECMDGOALS) )

clean:
	@find . -name "*.pyc" -exec rm -rf {} \;
	@find . -name "__pycache__" -delete
	rm -dr ./media_files
	rm -dr ./streampod_volume
	rm -dr ./logs
	rm -r ./celerybeat-schedule
	rm -dr ../postgres_data

test:
	poetry run backend/manage.py test backend/ $(ARG) --parallel --keepdb

test_reset:
	poetry run backend/manage.py test backend/ $(ARG) --parallel

backend_format:
	black backend 

# Commands for Docker version
docker_setup:
	docker volume create streampod_dbdata
	docker-compose build --no-cache backend
	docker-compose run frontend npm install

docker_test:
	docker-compose run backend python manage.py test $(ARG) --parallel --keepdb

docker_test_reset:
	docker-compose run backend python manage.py test $(ARG) --parallel

docker_up:
	docker-compose up -d

docker_up_dev:
	docker-compose -f docker-compose-dev.yaml up -d

docker_update_dependencies:
	docker-compose down
	docker-compose up -d --build

docker_down:
	docker-compose down
	rm -dr ../postgres_data

docker_down_dev:
	docker-compose down
	rm -dr ./streampod_volume

docker_logs:
	docker-compose logs -f $(ARG)

docker_makemigrations:
	docker-compose run --rm backend python manage.py makemigrations

docker_migrate:
	docker-compose run --rm backend python manage.py migrate
