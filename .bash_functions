function cl() {
    DIR="$*";
	# if no DIR given, go home
	if [ $# -lt 1 ]; then 
		DIR=$HOME;
    fi;
    builtin cd "${DIR}" && \
    # use your preferred ls command
	la --color=auto
}

mkcd ()
{
  mkdir -p -- "$1" && cd -P -- "$1"
}

enc-fix-keil ()
{
  find . -name '*.h' -exec iconv --verbose -f windows-1251 -t utf-8 -o {} {} \;
  find . -name '*.c' -exec iconv --verbose -f windows-1251 -t utf-8 -o {} {} \;
}

# yazi
function yy() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}
