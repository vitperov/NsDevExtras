#!/bin/bash

if [ -z "$NS2_CORE_PATH" ]; then
    echo 'Error: environment variable NS2_CORE_PATH is not declared'
    exit 1
fi

ROOT_DIR=$(pwd)

DEST_DIR=$NS2_CORE_PATH/external

if [ "$1" == "-debug" ] ; then
	CONFIGURATION="Debug"
    CONFIG_OPTIONS="CONFIG-=release CONFIG+=debug" 
else
	CONFIGURATION="Release"
    CONFIG_OPTIONS="CONFIG-=debug CONFIG+=release"
fi

DEST_BIN=$DEST_DIR/bin/x86-$CONFIGURATION

export QT_SELECT=qt5-x86_64-linux-gnu


# == Prepare build dir ==
export PATH=$PATH:$QTDIR/bin:$GCCDIR
export QMAKESPEC=linux-g++
export BUILD_DIR=$ROOT_DIR/../builds/build-NsDevExtras-$QMAKESPEC-$CONFIGURATION

# == Build NSWeightDevices ==
mkdir -p $BUILD_DIR
cd $BUILD_DIR
qmake "$ROOT_DIR/NsDevExtras.pro" -spec $QMAKESPEC $CONFIG_OPTIONS

make
if [ $? -ne 0 ] ; then
    echo NsDevExtras make failed
    exit 1
fi

# == Copy binaries ==
mkdir -p $DEST_BIN/devices/
cp $BUILD_DIR/libNsDevExtras* $DEST_BIN/devices/

echo Success
exit 0
