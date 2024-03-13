#!/bin/bash
#
# Deploy dotfiles.

# Write messages to stderr.
err() {
  echo "$*" >&2
}

main() {
  local workdir
  workdir="$(dirname "$(realpath "${0}")")"

  local configdir
  configdir="${XDG_CONFIG_HOME}"
  if [[ ! -d ${configdir} ]]; then
    configdir="${HOME}/.config"
  fi

  if ! mkdir -p "${configdir}" ; then
    err "Failed to make the config directory."
    exit 1
  fi

  if ! mkdir -p "${configdir}/git" ; then
    err "Failed to make the git config directory."
    exit 1
  fi

  if ! ln -sf "${workdir}/git/config" "${configdir}/git/config" ; then
    err "Failed to make the symbolic link to the git config."
    exit 1
  fi

  if ! ln -sf "${workdir}/git/ignore" "${configdir}/git/ignore" ; then
    err "Failed to make the symbolic link to the git ignore."
    exit 1
  fi

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
