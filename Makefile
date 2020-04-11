pwd = $(shell pwd)

setup:
	$(info Init the project)
	docker build -t php-runner ./docker/php-cli
	docker run -v $(pwd):/app -w /app php-runner composer install

install:
	$(info Install dependencies)
	docker run -v $(pwd):/app -w /app php-runner composer install

run:
	@php ./bin/brain-games

test:
	$(info Run tests)
	docker run -v $(pwd):/brain-games -w /brain-games php-runner vendor/bin/phpunit
	sed -i -e 's/\/brain-games\///g' build/logs/clover.xml

lint:
	$(info Run linter)
	docker run -v $(pwd):/brain-games -w /brain-games php-runner vendor/bin/phpcs --standard=PSR12 bin src

lint-fix:
	$(info Run linter with fixing)
	docker run -v $(pwd):/brain-games -w /brain-games php-runner vendor/bin/phpcbf --standard=PSR12 bin src

psalm:
	$(info Run static analysis)
	docker run -v $(pwd):/brain-games -w /brain-games php-runner vendor/bin/psalm --show-info=true bin src

require:
	$(info Install dependecy)
	docker run -v $(pwd):/brain-games -w /brain-games php-runner composer require $(p)

require-dev:
	$(info Install development dependecy)
	docker run -v $(pwd):/brain-games -w /brain-games php-runner composer require --dev $(p)
