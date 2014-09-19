#!/bin/bash

##
# settings
##
BROWSER=firefox

##
# code
##
EXE_PATH="`readlink -f $0`"
PRJ_PATH="${EXE_PATH%/*/*}"
PROJECT_LOWERCASE_NAME=`grep '\<SET *(PROJECT_LOWERCASE_NAME\>' "$PRJ_PATH"/CMakeLists.txt | sed 's~.*"\(.*\)".*~\1~'`

OUT_PATH="$PRJ_PATH/doc/html/$PROJECT_LOWERCASE_NAME"
OUT_INTERNAL_PATH="$PRJ_PATH/doc/html/$PROJECT_LOWERCASE_NAME-internals"

VALA_BASEDIR=`grep -v '\.\.' "$PRJ_PATH"/valadoc_env | grep '^BASEDIR=[-+A-Za-z0-9. ]\+$' | cut -d= -f2`
VALA_PKGS=`grep -v '\.\.' "$PRJ_PATH"/valadoc_env | grep '^PKGS=[-+A-Za-z0-9. ]\+$' | cut -d= -f2 | sed 's~\(^\| \)~ --pkg=~g; s~^ ~~'`

echo "Generating documentation..."
rm -rf "$OUT_PATH"
echo VALA_BASEDIR=$VALA_BASEDIR
echo VALA_PKGS=$VALA_PKGS
valadoc --no-protected -o "$OUT_PATH" -b "$PRJ_PATH/$VALA_BASEDIR" `find "$PRJ_PATH/$VALA_BASEDIR" -name "*.vapi" -or -name "*.vala"` $VALA_PKGS
$BROWSER "$OUT_PATH"/$PROJECT_LOWERCASE_NAME/index.htm &>/dev/null

#echo "Generating internal documentation..."
#rm -rf "$OUT_INTERNAL_PATH"
#valadoc -o "$OUT_INTERNAL_PATH" -b "$PRJ_PATH/$VALA_BASEDIR" `find "$PRJ_PATH/$VALA_BASEDIR" -name "*.vapi" -or -name "*.vala"` $VALA_PKGS --internal

#$BROWSER "$OUT_INTERNAL_PATH"/$PROJECT_LOWERCASE_NAME-internals/index.htm &>/dev/null
