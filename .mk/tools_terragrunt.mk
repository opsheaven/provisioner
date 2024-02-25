TERRAGRUNT_VERSION ?= 0.55.9

TERRAGRUNT_URL := https://github.com/gruntwork-io/terragrunt/releases/download/v$(TERRAGRUNT_VERSION)/terragrunt_linux_amd64
TERRAGRUNT_CHECK := $(shell basename $(shell which terragrunt) 2>/dev/null)
TERRAGRUNT_ACTIVE_VERSION := $(shell terragrunt --version 2>/dev/null|grep $(TERRAGRUNT_VERSION)|cut -d " " -f3)
TERRAGRUNT_EXPECTED := terragruntv$(TERRAGRUNT_VERSION)

.PHONY: tools/terragrunt
tools/terragrunt: ## Installs terragrunt if needed
ifneq ($(TERRAGRUNT_CHECK)$(TERRAGRUNT_ACTIVE_VERSION), $(TERRAGRUNT_EXPECTED))
	@echo "Installing terragrunt $(TERRAGRUNT_VERSION)"
	@curl -s -L $(TERRAGRUNT_URL) -o terragrunt && chmod +x terragrunt && sudo mv -f ./terragrunt /usr/local/bin/terragrunt
	@terragrunt --version
	@echo "terragrunt $(TERRAGRUNT_VERSION) installed"
else
	@echo "terragrunt ${TERRAGRUNT_VERSION} is already installed!"
endif
