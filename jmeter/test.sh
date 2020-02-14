#!/bin/bash
#
rootPath=$1
testFile=$2
host=$3

echo "Root path: $rootPath"
echo "Test file: $testFile"
echo "Host: $host"

T_DIR=.

# Reporting dir: start fresh
R_DIR=$T_DIR/report
rm -rf $R_DIR > /dev/null 2>&1
mkdir -p $R_DIR

rm -f $T_DIR/test-plan.jtl $T_DIR/jmeter.log  > /dev/null 2>&1

./run.sh $rootPath -Dlog_level.jmeter=DEBUG \
	-Jhost=$host \
	-n -t /test/$testFile -l $T_DIR/test-plan.jtl -j $T_DIR/jmeter.log \
	-e -o $R_DIR

echo "==== jmeter.log ===="
cat $T_DIR/jmeter.log

echo "==== Raw Test Report ===="
cat $T_DIR/test-plan.jtl

echo "==== HTML Test Report ===="
echo "See HTML test report in $R_DIR/index.html"