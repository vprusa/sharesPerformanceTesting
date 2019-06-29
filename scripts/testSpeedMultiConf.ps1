echo "this scripts run speed tests with different configurations"


# param([String]$target="smb", [Int32]$cycles=1, [Int32]$fcount=10000,[Int32]$fsize=10)


$now_file_format=Get-Date -Format yy_MM_dd_HH_mm_ss-fff
$log_dir=".\logs\log-$now_file_format\"
echo "Moving old logs"
#mv .\logs ".\logs-bkp-$now_file_format"
#mkdir .\logs
mkdir $log_dir

$DST_DIR="C:\test_drives\smb\"
Remove-Item –path $DST_DIR –recurse
mkdir $DST_DIR

$DST_DIR="C:\test_drives\nfs\"
Remove-Item –path $DST_DIR –recurse
mkdir $DST_DIR



$target="smb"
$cycles=1
$fsize=10
$fcount=10000
./testSpeed.ps1 -target $target -cycles $cycles -fcount $fcount -fsize $fsize | Tee $log_dir\test-$target-cycle_$cycles-fcount_$fcount-fsize_$fsize.log
$target="nfs"
./testSpeed.ps1 -target $target -cycles $cycles -fcount $fcount -fsize $fsize | Tee $log_dir\test-$target-cycle_$cycles-fcount_$fcount-fsize_$fsize.log


$target="smb"
$cycles=1
$fsize=10
$fcount=100000
./testSpeed.ps1 -target $target -cycles $cycles -fcount $fcount -fsize $fsize | Tee $log_dir\test-$target-cycle_$cycles-fcount_$fcount-fsize_$fsize.log
$target="nfs"
./testSpeed.ps1 -target $target -cycles $cycles -fcount $fcount -fsize $fsize | Tee $log_dir\test-$target-cycle_$cycles-fcount_$fcount-fsize_$fsize.log


$target="smb"
$cycles=1
$fsize=100
$fcount=10000
./testSpeed.ps1 -target $target -cycles $cycles -fcount $fcount -fsize $fsize | Tee $log_dir\test-$target-cycle_$cycles-fcount_$fcount-fsize_$fsize.log
$target="nfs"
./testSpeed.ps1 -target $target -cycles $cycles -fcount $fcount -fsize $fsize | Tee $log_dir\test-$target-cycle_$cycles-fcount_$fcount-fsize_$fsize.log


$target="smb"
$cycles=1
$fsize=1000
$fcount=10000
./testSpeed.ps1 -target $target -cycles $cycles -fcount $fcount -fsize $fsize | Tee $log_dir\test-$target-cycle_$cycles-fcount_$fcount-fsize_$fsize.log
$target="nfs"
./testSpeed.ps1 -target $target -cycles $cycles -fcount $fcount -fsize $fsize | Tee $log_dir\test-$target-cycle_$cycles-fcount_$fcount-fsize_$fsize.log

#
