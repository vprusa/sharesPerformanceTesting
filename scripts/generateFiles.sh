#!/bin/sh

echo "This script generates files"
if [ -z $1 ] || [ -z $2 ] ; then
echo "1. argument has to be MASTER_FILE_SIZE and second argument has to be single FILE_SIZE and third argument is DEST_DIR"
exit 0
fi
# https://www.heatware.net/linux-unix/create-large-many-number-files-thousands-millions/

MASTER_FILE_NAME="masterfile"
#MASTER_FILE_SIZE=1000000
MASTER_FILE_SIZE=$1
FILE_NAME_SIZE=$2
FILE_NAME_LENGHT=10
DEST_DIR=$3

cd ${DEST_DIR}
dd if=/dev/zero of=${MASTER_FILE_NAME} bs=1 count=${MASTER_FILE_SIZE}
split -b ${FILE_NAME_SIZE} -a ${FILE_NAME_LENGHT} ${MASTER_FILE_NAME}
rm -rf ${MASTER_FILE_NAME}
