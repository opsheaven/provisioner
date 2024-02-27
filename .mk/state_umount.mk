.PHONY: state/mount
state/mount:
	@mkdir -p state
	@sudo mount -t cifs //u393136.your-storagebox.de/backup/terraform ./state -o user=u393136,password=$(shell pass storagebox),noperm
