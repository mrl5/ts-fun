SHELL=/bin/sh

.PHONY: all help build run serve install lint test run-dev dev-run

all: help

build:
	docker build -t ts-fun .

run:
	docker run -p 3000:3000 ts-fun:latest

serve:
	docker run -d -p 3000:3000 ts-fun:latest

install:
	npm ci

lint:
	npm run lint

test:
	npm run test

run-dev:
	npm run dev

dev-run: run-dev


help:
	@echo "For available targets type: 'make ' and hit TAB"
	@echo
