v() {
	if [ $# -eq 0 ]; then
		vim .
	else
		vim "$@"
	fi
}

mkcd() {
	mkdir -p "$@" && cd "$_"
}

# Red STDERR
rse() {
	(set -o pipefail;"$@" 2>&1>&3|sed $'s,.*,\e[31m&\e[m,'>&2)3>&1
}

# Determine size of a file or total size of a directory
fs() {
	if du -b /dev/null >/dev/null 2>&1; then
		local arg=-sbh
	else
		local arg=-sh
	fi
	if [ "$@" ]; then
		du $arg -- "$@"
	else
		du $arg .[^.]* ./*
	fi
}
