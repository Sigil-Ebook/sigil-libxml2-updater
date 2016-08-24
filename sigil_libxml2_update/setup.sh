#!/bin/bash

# ensure running as root
if [ "$(id -u)" != "0" ]; then
  # exec sudo "$0" "$@"
  printf "\nThis installer needs to be run with root privileges.\n"
  exit 0
fi

# If not x86_64, assume 32-bit
if [ $(uname -m) == "x86_64" ]; then
  LIBXML="./libsigilxml2.so.2.9.4_64"
else
  LIBXML="./libsigilxml2.so.2.9.4_32"
fi

#Look for Sigil binary in the two most likely places.
DIRS="/usr/lib/sigil /usr/local/lib/sigil"
DEST=""
for DIR in ${DIRS}
do
  if [ -d ${DIR} ] && [ -x ${DIR}/sigil ]; then
    DEST=${DIR}
    break
  fi
done

if [ -z ${DEST} ]; then
  printf "\nCouldn't find Sigil's installation location. File copy cancelled.\n"
  exit 0
fi

MSG="Copy patched libxml2 to $DEST and create symlinks?"

# Copy libxml and create symlinks after user confirmation.
read -r -p "$MSG [y/N] " response
case ${response} in
  [yY][eE][sS]|[yY])
    \cp -fv ${LIBXML} ${DEST}/libsigilxml2.so.2.9.4
    ln -sfv ${DEST}/libsigilxml2.so.2.9.4 ${DEST}/libxml2.so.2
    ln -sfv ${DEST}/libsigilxml2.so.2.9.4 ${DEST}/libxml2.so
    printf "\nDone.\n"
    ;;
  *)
    printf "\nInstallation cancelled\n"
    exit 0
    ;;
esac
