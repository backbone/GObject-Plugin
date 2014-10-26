#!/bin/sh

##
# settings
##
PO_DIR_NAME=po
EXE_PATH="`readlink -f $0`"
PRJ_PATH="${EXE_PATH%/*/*}"
C_FILELIST="${PRJ_PATH}/src/*.vala"
UI_FILELIST="${PRJ_PATH}/ui/*.glade"
SOURCE_POT=source.pot
GLADE_POT=glade.pot

##
# code
##
PROJECT_LOWERCASE_NAME=`grep '\<SET *(PROJECT_LOWERCASE_NAME\>' "$PRJ_PATH"/CMakeLists.txt | sed 's~.*"\(.*\)".*~\1~'`
MAJOR=`grep '\<SET *(MAJOR\>' "$PRJ_PATH"/CMakeLists.txt | sed 's~.*\([0-9]\+\).*~\1~'`
PROJECT_LOWERCASE_NAME_ABI="$PROJECT_LOWERCASE_NAME-$MAJOR"

xgettext --language=C --escape --package-name=$PROJECT_LOWERCASE_NAME_ABI --default-domain=$PROJECT_LOWERCASE_NAME_ABI --add-comments=/// \
  -k_ -kQ_ -kC_ -kN_ -kNC_ -kg_dgettext -kg_dcgettext \
  -kg_dngettext -kg_dpgettext -kg_dpgettext2 -kg_strip_context -F -n -o \
  $PRJ_PATH/$PO_DIR_NAME/$SOURCE_POT $C_FILELIST

xgettext --language=C --escape --package-name=$PROJECT_LOWERCASE_NAME_ABI --default-domain=$PROJECT_LOWERCASE_NAME_ABI --add-comments=/// \
  -k_ -kQ_ -kC_ -kN_ -kNC_ -kg_dgettext -kg_dcgettext \
  -kg_dngettext -kg_dpgettext -kg_dpgettext2 -kg_strip_context -F -n -o \
  $PRJ_PATH/$PO_DIR_NAME/$GLADE_POT $C_FILELIST

msgcat -o $PRJ_PATH/$PO_DIR_NAME/$PROJECT_LOWERCASE_NAME_ABI.pot --use-first $PRJ_PATH/$PO_DIR_NAME/$SOURCE_POT $PRJ_PATH/$PO_DIR_NAME/$GLADE_POT

rm $PRJ_PATH/$PO_DIR_NAME/$SOURCE_POT
rm $PRJ_PATH/$PO_DIR_NAME/$GLADE_POT

[ 0 != $? ] && echo "xgettext failed ;-(" && exit 1
[ ! -e $PRJ_PATH/$PO_DIR_NAME/$PROJECT_LOWERCASE_NAME_ABI.pot ] && echo "No strings found ;-(" && exit 1

for d in $PRJ_PATH/$PO_DIR_NAME/*; do
  [ ! -d $d ] && continue

  if [ -e $d/$PROJECT_LOWERCASE_NAME_ABI.po ]; then
    echo "Merging '${d##*/}' locale" && msgmerge -F -U $d/$PROJECT_LOWERCASE_NAME_ABI.po $PRJ_PATH/$PO_DIR_NAME/$PROJECT_LOWERCASE_NAME_ABI.pot
    [ 0 != $? ] && echo "msgmerge failed ;(" && exit 1
  else
    echo "Creating '${d##*/}' locale" && msginit -l ${d##*/} -o  $d/$PROJECT_LOWERCASE_NAME_ABI.po -i $PRJ_PATH/$PO_DIR_NAME/$PROJECT_LOWERCASE_NAME_ABI.pot
    [ 0 != $? ] && echo "msginit failed ;(" && exit 1
  fi

done
