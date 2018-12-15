# Self documented Makefile
# http://marmelab.com/blog/2016/02/29/auto-documented-makefile.html
.PHONY: help
help: ## Show list of make targets and their description
	@grep -E '^[%.a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
		| awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-15s\033[0m %s\n", $$1, $$2}'

.DEFAULT_GOAL:= help

.PHONY: setup
setup: ## Run setup scripts to prepare development environment
	@scripts/setup.sh

.PHONY: clean
clean: ## Clean project dir, remove build artifacts and logs
	@scripts/clean.sh

build.%: ## Build deployable targets. Try `make build.android` to build android debug apk or `make build` to learn more
	@scripts/build.sh $*


# This one is added to help `make build` show help info for the build script
define BUILD_HELP
---
If you are using make command to build, append the target to build
command, like `make build.android`, `make build.android.release`.
Don't use space, as make won't recognize that.
endef

export BUILD_HELP
build:
	@scripts/build.sh "$*"
	@echo "$${BUILD_HELP}"

