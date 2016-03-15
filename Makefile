.PHONY:
all:
	bundle install
	bundle exec rake db:migrate

.PHONY:
run:
	bundle exec rails server

.PHONY:
copy-config-files:
	cp config/database.example.yml config/database.yml
	cp config/local_env.example.yml config/local_env.yml
	cp config/billig.example.yml config/billig.yml

.PHONY:
copy-travis-files:
	cp config/database.travis.yml config/database.yml

.PHONY:
test:
	bundle exec rubocop -R -D
