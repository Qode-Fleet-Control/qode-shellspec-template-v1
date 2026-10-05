# shellcheck shell=sh
# strings.sh — a small POSIX sh library: source it, then call its functions.
#
#   . lib/strings.sh
#   to_upper "hello"          # -> HELLO
#   str_repeat "ab" 3         # -> ababab
#   is_semver "1.2.3"         # status 0 (true) / 1 (false)
#   semver_bump minor 1.2.3   # -> 1.3.0

to_upper() {
  printf '%s\n' "$1" | tr '[:lower:]' '[:upper:]'
}

# str_repeat STRING COUNT
str_repeat() {
  _s='' _i=0
  while [ "$_i" -lt "$2" ]; do _s="$_s$1"; _i=$((_i + 1)); done
  printf '%s\n' "$_s"
}

# is_semver STRING — true when STRING is MAJOR.MINOR.PATCH (digits only)
is_semver() {
  printf '%s\n' "$1" | grep -Eq '^[0-9]+\.[0-9]+\.[0-9]+$'
}

# semver_bump major|minor|patch VERSION — print the next version.
# Returns 1 with a message on stderr for a bad part or version.
semver_bump() {
  if ! is_semver "$2"; then
    echo "semver_bump: not a version: $2" >&2
    return 1
  fi
  _major=${2%%.*} _rest=${2#*.}
  _minor=${_rest%%.*} _patch=${_rest#*.}
  case $1 in
    major) echo "$((_major + 1)).0.0" ;;
    minor) echo "$_major.$((_minor + 1)).0" ;;
    patch) echo "$_major.$_minor.$((_patch + 1))" ;;
    *) echo "semver_bump: unknown part: $1" >&2; return 1 ;;
  esac
}
