TFLINT_VERSION ?= 0.50.3

TFLINT_URL := https://github.com/terraform-linters/tflint/releases/download/v$(TFLINT_VERSION)/tflint_linux_amd64.zip
TFLINT_CHECK := $(shell basename $(shell which tflint) 2>/dev/null)
TFLINT_ACTIVE_VERSION := $(shell tflint --version 2>/dev/null|grep $(TFLINT_VERSION)|cut -d " " -f3)
TFLINT_EXPECTED := tflint$(TFLINT_VERSION)

.PHONY: tools/tflint
tools/tflint:
ifneq ($(TFLINT_CHECK)$(TFLINT_ACTIVE_VERSION), $(TFLINT_EXPECTED))
	@echo "Installing tflint $(TFLINT_VERSION)"
	@curl -s -L $(TFLINT_URL) -o tflint.zip && unzip tflint.zip && sudo mv -f tflint /usr/local/bin/tflint && rm -rf tflint.zip
	@tflint --version
	@echo "tflint ${TFLINT_VERSION} installed"
else
	@echo "tflint ${TFLINT_VERSION} is already installed!"
endif
