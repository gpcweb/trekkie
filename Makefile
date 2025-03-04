SERVICE_NAME:=trekkie
IMAGE_TAG:=$(shell git rev-parse HEAD)

build:
	DOCKER_BUILDKIT=1 \
	docker build \
		--progress=plain \
		--tag ${SERVICE_NAME} . \
		--build-arg CONTAINERID=$(IMAGE_TAG);

start: build
	docker-compose up -d;

up:
	docker-compose up -d

stop:
	docker-compose stop

setup-db:
	docker-compose exec app bundle exec rake db:create && \
	docker-compose exec app bundle exec rake db:migrate RAILS_ENV=test && \
	docker-compose exec app bundle exec rake db:migrate

console:
	docker-compose exec app bundle exec rails console

bash:
	docker-compose exec app bundle exec bash
