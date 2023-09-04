#!/bin/zsh


_echoerr() { printf "%s\n" "$*" >&2; }


_echo_and_exit_failed() { _echoerr $1; exit ${2:-1}; }


_term_if_not_found() {
	_delim
	echo "checking for $1"
	if ! $1 ${2:-"-v"} &> /dev/null; then
		_echo_and_exit_failed "$1 not found"
	fi
	echo "found $1"
}


_term_if_pyenv_version_not_installed() {
	_delim
	if ! pyenv versions | grep -q $1; then
		_echo_and_exit_failed "pyenv version $1 not found"
	fi
}


_delim() {
	printf "=%.0s" {1..50}; echo ""; 
}


echo "running $0 before creating project"
echo "performing basic validation"

_term_if_not_found pyenv
_term_if_not_found direnv version
_term_if_pyenv_version_not_installed {{cookiecutter.python_version}}

_delim
echo "basic validation passed"
