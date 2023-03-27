SHELL := /bin/bash

include .env 

hello:
	@echo "Hello World"
	@echo "env var for AWS Region = ${AWS_REGION}"
	# printenv | grep AWS*


install:
	cat requirements.txt | xargs poetry add
	cat requirements_dev.txt | xargs  poetry add  --group dev

install_dev:
	cat requirements_dev.txt | xargs  poetry add  --group dev

# post-install:
#     python -m textblob.download_corpora

git:
	# Update Git Repo
	bash sync_git

# virtual_env:
# 	python3 -m venv $(VENV)
# 	. $(VENV)/bin/activate 

# install_virtualenv:
# 	make virtual_env
# 	python3 -m pip install --upgrade pip 
# 	python3 -m pip install pyyaml==5.1.2
# 	@make env_activate 

# env_activate:
# 	@echo "------ Make sure to activate virtual environment again --------"

# aws_connect:
# 	printenv | grep AWS*
# 	# poetry run python -m src/aws_config.py

airflow-up:
	@docker-compose up --build

airflow-down:
	@docker-compose down

infra-get:
	cd infrastructure && terraform get;

infra-init: infra-get
	cd infrastructure && terraform init -upgrade;

infra-plan: infra-init
	cd infrastructure && terraform plan;

infra-apply: infra-plan
	cd infrastructure && terraform apply --auto-approve;

infra-plan-destroy:
	cd infrastructure && terraform plan -destroy;

infra-destroy:
	cd infrastructure && terraform destroy --auto-approve;

clean:
	rm -rf postgres_data
	rm -rf __pycache__