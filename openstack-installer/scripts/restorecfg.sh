#!/bin/sh -e

if [ -z "$1" ]; then
    echo "Usage: $0 config_name"
    echo
    echo "$0: restores the saved config 'config_name' from configs"
    exit 0
fi

BASEDIR=$(dirname "$0")/..
CONFDIR="$BASEDIR/configs/$1"
cp "$CONFDIR"/group_vars/all/* "$BASEDIR"/group_vars/all
cp "$CONFDIR/inventory/inventory.yml" "$BASEDIR/inventory/inventory.yml"
rm -rf "$BASEDIR"/files/* 2>/dev/null || /bin/true
cp -r "$CONFDIR"/files "$BASEDIR" || /bin/true
grep -q "^\$ANSIBLE_VAULT" "$BASEDIR"/group_vars/all/secrets.yml && ansible-vault decrypt "$BASEDIR"/group_vars/all/secrets.yml
rm "$BASEDIR/workdir/"* 2>/dev/null || /bin/true
