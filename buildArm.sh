#!/bin/bash

if [ -z "$NS2_CORE_PATH" ]; then
    echo 'Error: environment variable NS2_CORE_PATH is not declared'
    exit 1
fi

export ROOT_DIR=$(pwd)
export DEST_DIR=$NS2_CORE_PATH/external

if [ "$1" == "-debug" ] ; then
	CONFIGURATION="Debug"
    CONFIG_OPTIONS="CONFIG-=release CONFIG+=debug" 
else
	CONFIGURATION="Release"
    CONFIG_OPTIONS="CONFIG-=debug CONFIG+=release"
fi

DEST_BIN=$DEST_DIR/bin/arm-$CONFIGURATION

source $ROOT_DIR/scripts/armConfig.sh

export PATH=$PATH:$QTDIR/bin:$GCCDIR
export QMAKESPEC=linux-linaro-gnueabihf-g++
export BUILD_DIR=$ROOT_DIR/../builds/build-NsDevExtras-$QMAKESPEC-$CONFIGURATION

mkdir -p $BUILD_DIR
cd $BUILD_DIR

$QTDIR/bin/qmake "$ROOT_DIR/NsDevExtras.pro" -spec $QMAKESPEC $CONFIG_OPTIONS

make
if [ $? -ne 0 ] ; then
    echo NsDevExtras make failed
    exit 1
fi

mkdir -p $DEST_BIN/devices/
cp $BUILD_DIR/libNsDevExtras.so $DEST_BIN/devices

echo Success
exit 0

