include $(wildcard .mk/*.mk)

.PHONY: help
help: ## Provides help menu
	@echo "Usage:"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) |\
	awk 'BEGIN {FS = ":.*?## "}; {printf "make ${CYAN}%-30s${CNone} %s\n", $$1, $$2}'

.PHONY: tools
tools: tools/terraform tools/terragrunt tools/tflint tools/terraform_docs ## Install Required Tools

.PHONY: release
release: release/release ## Generate release
