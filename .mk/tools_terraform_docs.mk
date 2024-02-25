TFDOCS_VERSION ?= 0.17.0

TFDOCS_URL := https://github.com/terraform-docs/terraform-docs/releases/download/v$(TFDOCS_VERSION)/terraform-docs-v$(TFDOCS_VERSION)-linux-amd64.tar.gz
TFDOCS_CHECK := $(shell basename $(shell which terraform_docs) 2>/dev/null)
TFDOCS_ACTIVE_VERSION := $(shell terraform_docs --version 2>/dev/null|grep $(TFDOCS_VERSION)|cut -d " " -f3)
TFDOCS_EXPECTED := terraform_docsv$(TFDOCS_VERSION)

.PHONY: tools/terraform_docs
tools/terraform_docs: ## Installs terraform docs if needed
ifneq ($(TFDOCS_CHECK)$(TFDOCS_ACTIVE_VERSION), $(TFDOCS_EXPECTED))
	@echo "Installing terraform_docs $(TFDOCS_VERSION)"
	@mkdir -p tfdocs && curl -s -L $(TFDOCS_URL)  | tar -xvzf - -C ./tfdocs && sudo mv -f ./tfdocs/terraform-docs /usr/local/bin/terraform-docs && rm -rf tfdocs
	@terraform-docs --version
	@echo "terraform_docs $(TFDOCS_VERSION) installed"
else
	@echo "terraform_docs ${TFDOCS_VERSION} is already installed!"
endif
