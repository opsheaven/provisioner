.PHONY: state/mount
state/mount:
	@mkdir -p state
	@sshfs u393136@u393136.your-storagebox.de:/terraform ./state -o ssh_command="sshpass -p $(shell pass storagebox) ssh"
