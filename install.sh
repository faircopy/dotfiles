#!/usr/bin/env bash

get_os() {
	local -r os="$(sed -n 's,^NAME=\(.*\),\1,p' /etc/os-release)"

	if [ -z "$os" ]; then
		echo >&2 "Error: OS type not found"
		exit 1
	fi

	echo "$os"
}

configure() {
	CONF_USER=(
		['home/.vim/colors/xoria256.vim']="$HOME/.vim/colors/xoria256.vim"
		['home/.bash_logout']="$HOME/.bash_logout"
		['home/.bash_profile']="$HOME/.bash_profile"
		['home/.bashrc']="$HOME/.bashrc"
		['home/.profile']="$HOME/.profile"
		['home/.tmux.conf']="$HOME/.tmux.conf"
		['home/.vimrc']="$HOME/.vimrc"
	)

	case "$OS" in
		'Gentoo')
			CONF_ROOT+=(
				['etc/bashrc.d/aliases.sh']='/etc/bash/bashrc.d/aliases.sh'
				['etc/bashrc.d/env.sh']='/etc/bash/bashrc.d/env.sh'
				['etc/bashrc.d/functions.sh']='/etc/bash/bashrc.d/functions.sh'
				['etc/bashrc.d/prompt.sh']='/etc/bash/bashrc.d/prompt.sh'
			)
			;;
		'Fedora'|'Ubuntu'|'LinuxMint')
			CONF_ROOT+=(
				['etc/bashrc.d/aliases.sh']='/etc/profile.d/Z99-aliases.sh'
				['etc/bashrc.d/env.sh']='/etc/profile.d/Z99-env.sh'
				['etc/bashrc.d/functions.sh']='/etc/profile.d/Z99-functions.sh'
				['etc/bashrc.d/prompt.sh']='/etc/profile.d/Z99-prompt.sh'
			)
			;;
		*)
			echo >&2 'Error: OS unknown'
			exit 1
			;;
	esac
}

copy_dotfiles() {
	cd "$(dirname "$0")"

	echo 'Home:'
	echo '-----'
	for i in "${!CONF_USER[@]}"; do
		if ! cmp --quiet "$i" "${CONF_USER[$i]}"; then
			mkdir -p "$(dirname "${CONF_USER[$i]}")"
			cp -riv --preserve=timestamps -- "$i" "${CONF_USER[$i]}"
		fi
	done

	echo
	echo 'Root:'
	echo '-----'
	if sudo true; then
		for i in "${!CONF_ROOT[@]}"; do
			if ! cmp --quiet "$i" "${CONF_ROOT[$i]}"; then
				sudo mkdir -p "$(dirname "${CONF_ROOT[$i]}")"
				sudo cp -riv --preserve=timestamps -- "$i" "${CONF_ROOT[$i]}"
			fi
		done
	else
		echo >&2 "Error: Couldn't sudo"
		exit 1
	fi
}

declare -r OS="$(get_os)"
declare -A CONF_USER CONF_ROOT

configure
copy_dotfiles
