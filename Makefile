PWD = $(shell pwd)

install:
	$(info Install dependencies)
	docker run -v $(PWD):/app -w /app php-runner composer install

setup:
	$(info Init the project)
	docker build -t php-runner ./docker/php-cli
	docker run -v $(PWD):/app -w /app php-runner composer install

lint:
	$(info Run linter)
	docker run -v $(PWD):/brain-games -w /brain-games php-runner vendor/bin/phpcs --standard=PSR12 bin

lint-fix:
	$(info Run linter with fixing)
	docker run -v $(PWD):/brain-games -w /brain-games php-runner vendor/bin/phpcbf --standard=PSR12 bin

psalm:
	$(info Run static analysis)
	docker run -v $(PWD):/brain-games -w /brain-games php-runner vendor/bin/psalm --show-info=true bin
