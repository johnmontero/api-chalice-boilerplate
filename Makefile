.DEFAULT_GOAL := help
.PHONY: help 

## VARIABLES ##
BASE_PATH = app
PROJECT_NAME = api-chalice-boilerplate
IMAGE = $(PROJECT_NAME):latest
DEPLOY_REGION ?= eu-west-1
ENV ?= dev

# Container
copy_requirements:
	@cp $(BASE_PATH)/requirements.txt docker/resources/requirements.txt

build.image: copy_requirements ## Build image for development: make build.image
	@docker build -f docker/Dockerfile -t $(IMAGE) ./docker
	@rm docker/resources/requirements.txt

container:
	@docker run --rm -it\
	 -v $(PWD)/$(BASE_PATH):/$(BASE_PATH) \
	 -v ~/.aws/config:/root/.aws/config \
	 -v ~/.aws/credentials:/root/.aws/credentials \
	 -w /$(BASE_PATH) \
	 -e AWS_DEFAULT_REGION=${DEPLOY_REGION} \
	 -p 8080:8080/ \
	 $(IMAGE) \
	 $(COMMAND)

ssh: ## Connect to the container by ssh: make ssh
	@make container COMMAND=sh

# Chalice
deploy: ## Deploying project: make deploy
	@make container COMMAND="chalice deploy --stage $(ENV)"

delete: ## Eliminating project deployment: make delete
	@make container COMMAND="chalice delete --stage $(ENV)"

run.local: ## Locally executing the project: make run.local
	@make container COMMAND="chalice local --host=0.0.0.0 --port=8080 --stage=local"


## HELP ##
help:
	@printf "\033[31m%-16s %-59s %s\033[0m\n" "Target" "Help" "Usage"; \
	printf "\033[31m%-16s %-59s %s\033[0m\n" "------" "----" "-----"; \
	grep -hE '^\S+:.*## .*$$' $(MAKEFILE_LIST) | sed -e 's/:.*##\s*/:/' | sort | awk 'BEGIN {FS = ":"}; {printf "\033[32m%-16s\033[0m %-58s \033[34m%s\033[0m\n", $$1, $$2, $$3}'

