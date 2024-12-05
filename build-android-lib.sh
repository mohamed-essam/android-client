#!/bin/bash
# bash build-android-lib.sh ~/projects/netbird

set -e

rn_app_path=$(pwd)
netbirdPath=$1
if [ -z "${1+x}" ]
then
    netbirdPath=${GOPATH}/src/github.com/netbirdio/netbird
fi

version=$2
if [ -z "${2+x}" ]
then
    version=development
fi

cd $netbirdPath
gomobile init
CGO_ENABLED=0 gomobile bind  -o $rn_app_path/android/netbird/netbird.aar -javapkg=io.netbird.gomobile  -ldflags="-X golang.zx2c4.com/wireguard/ipc.socketDirectory=/data/data/io.netbird.client/cache/wireguard -X github.com/netbirdio/netbird/version.version=$version -checklinkname=0" $netbirdPath/client/android

cd -
