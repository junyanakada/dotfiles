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

  if ! ln -sf "${workdir}/black/black" "${configdir}/black" ; then
    err "Failed to make the symbolic link to the black config."
    exit 1
  fi

  if ! mkdir -p "${HOME}/.vim" ; then
    err "Failed to make the vim config directory."
    exit 1
  fi

  if [[ ! -f "${HOME}/.vim/autoload/plug.vim" ]]; then
    if ! which wget >/dev/null ; then
      err "Wget is not executable."
    fi

    if ! wget -q -P "${HOME}/.vim/autoload" \
      "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
    then
      err "Failed to download vim-plug."
    fi
  fi

  if ! ln -sf "${workdir}/vim/vimrc" "${HOME}/.vim/vimrc" ; then
    err "Failed to make the symbolic link to the vimrc."
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
