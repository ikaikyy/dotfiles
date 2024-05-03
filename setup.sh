ask_for_confirmation() {
  read -p "$1 [y/N] " -n 1 -r
  echo

  if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    return 1
  fi
}

remove_existing_symlink() {
  if [[ -L $1 ]]; then
    rm $1
  fi
}

backup_if_exists() {
  if [[ -e $1 ]]; then
    if [[ ! -L $1 && -e $PWD/.bak ]]; then
      rm -rf $PWD/.bak
    fi

    mkdir -p $PWD/.bak
    mv $1 $PWD/.bak
  fi
}

ask_for_confirmation "Conflicting files from $HOME/.config will be backed up on in your current directory ($PWD/.bak) and symlinks will be removed. Continue?" || exit 1

while read line; do
  if [[ $line == \#* || $line == "" ]]; then
    continue
  fi

  IFS=: read -r key value action <<< "$line"

  if [[ ! $value ]]; then
    value=$HOME/.config/$key
  elif [[ ! $value == /* ]]; then
    value=$HOME/$value
  fi

  remove_existing_symlink $value
  backup_if_exists $value

  if [[ $action == "copy" ]]; then
    mkdir -p $value
    cp -r $PWD/$key $value
  else
    ln -s $PWD/$key $value
  fi
done < setup.conf
