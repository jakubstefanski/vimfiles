#!/bin/sh

set -eu

repo_dir=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd -P)
runtime_dir=$HOME/.vim

link_path() {
	source=$1
	destination=$2

	if [ -L "$destination" ]; then
		current=$(readlink "$destination")
		if [ "$current" = "$source" ]; then
			return
		fi
		printf 'error: %s points to %s, expected %s\n' \
			"$destination" "$current" "$source" >&2
		exit 1
	fi

	if [ -e "$destination" ]; then
		printf 'error: %s already exists; move or merge it first\n' \
			"$destination" >&2
		exit 1
	fi

	ln -s "$source" "$destination"
	printf 'linked %s -> %s\n' "$destination" "$source"
}

if [ "$repo_dir" != "$runtime_dir" ]; then
	link_path "$repo_dir" "$runtime_dir"
fi

link_path "$runtime_dir/vimrc" "$HOME/.vimrc"
link_path "$runtime_dir/gvimrc" "$HOME/.gvimrc"

printf 'Vim configuration installed successfully.\n'
