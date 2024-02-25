TERRAFORM_VERSION ?= 1.7.4

TERRAFORM_URL := https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip
TERRAFORM_CHECK := $(shell basename $(shell which terraform) 2>/dev/null)
TERRAFORM_ACTIVE_VERSION := $(shell terraform --version 2>/dev/null|grep $(TERRAFORM_VERSION)|cut -d " " -f2)
TERRAFORM_EXPECTED := terraformv$(TERRAFORM_VERSION)

.PHONY: tools/terraform
tools/terraform: ## Installs terraform if needed
ifneq ($(TERRAFORM_CHECK)$(TERRAFORM_ACTIVE_VERSION), $(TERRAFORM_EXPECTED))
	@echo "Installing terraform $(TERRAFORM_VERSION)"
	@curl -s -L $(TERRAFORM_URL) -o tf.zip && unzip tf.zip && sudo mv -f terraform /usr/local/bin/terraform && rm -rf tf.zip
	@terraform --version
	@echo "terraform $(TERRAFORM_VERSION) installed"
else
	@echo "terraform ${TERRAFORM_VERSION} is already installed!"
endif
