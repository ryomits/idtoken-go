PWD:=$(shell pwd)
TARGET=...

.PHONY: help
help: ## Display this help screen
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.PHONY: test
test: ## Run test API server
	APP_ENV=test richgo test -cover idtoken-go/${TARGET}

.PHONY: lint
lint: ## Run linter
	find . -name \*.go -not -path "./gen/*" -exec goimports -w -local negroni {} +
	golangci-lint run

.PHONY: cover
cover: ## Check coverage
	APP_ENV=test go test ./... -coverprofile cover.out
	go tool cover -html=cover.out -o cover.html
