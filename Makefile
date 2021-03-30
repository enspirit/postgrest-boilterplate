SHELL=/bin/bash -o pipefail
-include .env
.EXPORT_ALL_VARIABLES: ;

COMPONENTS := api dbagent postgres tests

### docker-compose global rules

install: uninstall db.migrate

uninstall: down db.drop

ps:
	docker-compose ps

up:
	docker-compose up -d api

down:
	docker-compose down

test: up
	docker-compose run tests webspicy .

### docker-compose component lifecycle rules

define make-goal
$1.up:
	docker-compose up -d --force-recreate $1

$1.down:
	docker-compose stop $1

$1.restart:
	docker-compose restart $1

$1.bash:
	docker-compose exec $1 bash

$1.logs:
	docker-compose logs $1
endef
$(foreach component,$(COMPONENTS),$(eval $(call make-goal,$(component))))

### Database specific rules

db.drop:
	sudo rm -rf volumes/pgdata

db.migrate:
	docker-compose run dbagent bundle exec rake db:wait db:migrate

db.base:
	docker-compose run dbagent bundle exec rake "db:seed[test/base]"

db.repl:
	docker-compose run dbagent bundle exec rake db:wait db:repl
