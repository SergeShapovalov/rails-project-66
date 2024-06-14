setup: install

install:
	cp -n .env.example .env || true
	yarn install
	bundle install
	DISABLE_DATABASE_ENVIRONMENT_CHECK=1 bundle exec rails db:drop
	bundle exec rails db:create
	bundle exec rails db:migrate
	bundle exec rails db:seed
	bundle exec rails assets:precompile

test:
	bundle exec rake test

lint:
	bundle exec rubocop

slim-lint:
	slim-lint app/views/

run:
	bundle exec rails s

.PHONY: test
