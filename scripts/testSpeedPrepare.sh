#!/bin/bash

echo "This script generate files in dir and copy them to other location and check time it took"

if [ -z $FILE_COUNT ] ; then
FILE_COUNT=10000
fi
if [ -z $FILE_SIZE ] ; then
#LOG_SEARCHED_STR="testing/$FILE_COUNT-testUniqueStr"
FILE_SIZE=10
fi
if [ -z $SCRIPTS_DIR ] ; then
SCRIPTS_DIR=`dirname "${BASH_SOURCE[0]}"`
fi
if [ -z $DEST_BASE_DIR ] ; then
  DEST_BASE_DIR=`pwd`
fi
if [ -z $LOG_FILE ] ; then
LOG_FILE=/var/log/messages
fi
if [ -z $RESULT_FILE ] ; then
RESULT_FILE="nfs-result.txt"
fi
if [ -z $NOW_FILE_STR ] ; then
NOW_FILE_STR=`date +%Y-%m-%d_%H-%M-%S`
fi
if [ -z $DIR_UNIQUE_STR ] ; then
DIR_UNIQUE_STR="testUniqueStr"
fi
if [ -z $TEST_DIR ] ; then
TEST_DIR=${DEST_BASE_DIR}"/"${FILE_COUNT}"-"${DIR_UNIQUE_STR}
fi

echo "SCRIPTS_DIR: ${SCRIPTS_DIR}"
echo "DEST_BASE_DIR: ${DEST_BASE_DIR}"


if ! [ -z $AS_ROOT ] ; then
mv $LOG_FILE ${LOG_FILE}.${NOW_FILE_STR}
#mkdir $LOG_FILE
touch $LOG_FILE

mv $RESULT_FILE ${RESULT_FILE}.${NOW_FILE_STR}


# to refresh log files
systemctl restart network
systemctl restart rsyslog
#rpcdebug -m nfsd -s proc
#rpcdebug -m nfsd all -s proc
#rpcdebug -m nfsd all
rpcdebug -m nfsd -c all
rpcdebug -m nfsd -s proc
rpcdebug -m nfsd all -s proc

#rpcdebug -m nfsd all
#rpcdebug -m nfsd -c all
rpc.mountd -d all

systemctl restart nfs
systemctl restart nfs-server
systemctl restart network

fi

rm -rf ${TEST_DIR}
mkdir ${TEST_DIR}

echo "generateFiles.sh $FILE_COUNT $FILE_SIZE ${TEST_DIR}" >> $RESULT_FILE

${SCRIPTS_DIR}/generateFiles.sh $FILE_COUNT $FILE_SIZE ${TEST_DIR}

#if ! [ -z $AS_ROOT ] ; then
chmod -R +777 $TEST_DIR
#fi
# do some magic (copy all) on Windwos side
