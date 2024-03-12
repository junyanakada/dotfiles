#!/bin/bash
#
# Deploy dotfiles.

# Write messages to stderr.
err() {
  echo "[$(date +'%Y-%m-%dT%H:%M:%S%z')]: $*" >&2
}

main() {
  local workdir
  workdir="$(dirname "$(realpath "${0}")")"

  if ! ln -sf "${workdir}/bash/bash_profile" "${HOME}/.bash_profile" ; then
    err "Failed to make the symbolic link to the bash_profile."
    exit 1
  fi

  if ! ln -sf "${workdir}/bash/bashrc" "${HOME}/.bashrc" ; then
    err "Failed to make the symbolic link to the bashrc."
    exit 1
  fi
}

main "$@"
