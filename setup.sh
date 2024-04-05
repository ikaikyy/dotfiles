ask_for_confirmation() {
  read -p "$1 [y/N] " -n 1 -r
  echo

  if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    return 1
  fi
}

backup_if_exists() {
  if [[ -e $1 ]]; then
    mkdir -p $PWD/.bak
    mv $1 $PWD/.bak
  fi
}

ask_for_confirmation "Conflicting files from $HOME/.config will be backed up on in your current directory ($PWD/.bak). Continue?" || exit 1

while read line; do
  if [[ $line == \#* || $line == "" ]]; then
    continue
  fi

  IFS=: read -r key value <<< "$line"

  if [[ ! $value ]]; then
    value=$HOME/.config/$key
  elif [[ ! $value == /* ]]; then
    value=$HOME/$value
  fi

  backup_if_exists $value

  ln -s $PWD/$key $value
done < setup.conf
