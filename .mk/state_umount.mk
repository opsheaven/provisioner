.PHONY: state/umount
state/umount:
	@umount ./state
	@rm -rf ./state
