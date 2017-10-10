#!/bin/sh

PROFILE="$HOME/.profile"
INSTALLED_STR="install_skopos"

if mkdir -p $HOME/bin 2>/dev/null
then
# This cp will not clobber any
# existing files without explicit
# permission.
  if cp -iavp bin/* $HOME/bin
  then
    echo "Files installed successfully..."

    if grep -c "$INSTALLED_STR" $PROFILE
    then
      cat <<E >> $HOME/.profile

## $INSTALLED_STR
if [[ -e $HOME/bin/skopos ]]
then
  echo "Setting up kraken environment..."
  source $HOME/bin/skopos
  setup_cluster_env
fi
## end install_skopos
E
    else
      echo "Skipping addition to $PROFILE. I think it exists already."
    fi
  else
    echo >&2 "Installation didn't fully succeed, but things might still be OK."
    exit 2
  fi
else
  echo >&2 "Unable to mkdir $HOME/bin. RC was $?"
fi

echo "Installation is complete. You should logout and log back in, or source your $PROFILE"
