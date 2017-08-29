PROMPT_COMMAND=__prompt_command

__prompt_command() {
	local exit_code="$?"
	local user_color exit user hostname workdir

	if [ "$EUID" -eq 0 ]; then
		user_color='\[\033[1;31m\]'
	else
		user_color='\[\033[1;32m\]'
	fi

	if [ "$exit_code" -ne 0 ]; then
		exit="\[\033[1;31m\]${exit_code}\[\033[0m\] "
	fi

	user="${user_color}\u\[\033[0m\]"
	hostname='\[\033[1;34m\]\h\[\033[0m\]'
	workdir='\[\033[1;35m\]\w\[\033[0m\]'

	PS1="${exit}${user}\[\033[1;30m\]@\[\033[0m\]${hostname} ${workdir} \[\033[1;30m\]\$\[\033[0m\] "
}
