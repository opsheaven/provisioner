.PHONY: state/umount
state/umount:
	@sudo umount ./state
	@rm -rf ./state
