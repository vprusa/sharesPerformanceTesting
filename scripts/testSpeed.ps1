#Get-PSDrive

param([String]$target="smb", [Int32]$cycles=1, [Int32]$fcount=10000,[Int32]$fsize=10)

$TEST_TARGET=$target
#$TEST_TARGET="smb"

$CYCLES=$cycles
$SSH_TARGET="<your ssh...>"

$TotalMilliseconds=0
$StopWatch = New-Object System.Diagnostics.Stopwatch
$FILE_COUNT=$fcount
$FILE_SIZE=$fsize

$REMOTE_WORKSPACE_DIR="/home/prusa/workspace/p/cvis_notes/tasks"
if($TEST_TARGET -eq "nfs"){
echo "Lets test NFS"
$SRC_DIR="Y:\testing\10000-testUniqueStr"
}elseif($TEST_TARGET -eq "smb"){
echo "Lets test Samba"
$SRC_DIR="Z:\testing\10000-testUniqueStr"
}else{
echo "Nothing to test"
exit
}

$DST_DIR="C:\test_drives\$TEST_TARGET"

for($i = 0 ; $i -lt $CYCLES ; $i++){

echo "Cycle: $i"
#echo "Will copy from $SRC_DIR to $DST_DIR"

echo "Clean dst $DST_DIR"
rm -r -fo $DST_DIR
mkdir $DST_DIR

Get-Date -Format HH:mm:ss.fff
echo "Run script for env preparation"
ssh $SSH_TARGET "export FILE_COUNT=$FILE_COUNT FILE_SIZE=$FILE_SIZE ; $REMOTE_WORKSPACE_DIR/$TEST_TARGET/scripts/testNfsSpeedPrepare.sh"

Get-Date -Format HH:mm:ss.fff
#echo "load or keep loaded drives"
echo "Copy from $SRC_DIR to $DST_DIR"
$StopWatch.Start()
cp $SRC_DIR $DST_DIR\
$StopWatch.Stop()
$StopWatch.Elapsed
$StopWatch.Elapsed.TotalMilliseconds
echo "${StopWatch.Get_ElapsedMilliseconds}"

$TotalMilliseconds+=$StopWatch.Elapsed.TotalMilliseconds

}

echo "Cycles done: $CYCLES , for target: $TEST_TARGET , "

$AverageOperationTime=$TotalMilliseconds/$CYCLES

echo "AverageOperationTime: $AverageOperationTime"

Get-Date -Format HH:mm:ss.fff
#echo "run script for results analyses"
#ssh $SSH_TARGET '$REMOTE_WORKSPACE_DIR/$TEST_TARGET/scripts/testSpeedAnalyse.sh'
#Get-Date -Format HH:mm:ss.fff
echo "Done"
