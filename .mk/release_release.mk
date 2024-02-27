.PHONY: release/release
release/release:
	@gh release create $(TAG) --generate-notes
