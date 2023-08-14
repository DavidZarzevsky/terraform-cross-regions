#!/usr/bin/env bash
set -x

CWD=$(pwd)
FULL_CLIENT_CERTIFICATE_NAME=$CERT_ISSUER


cd $PKI_FOLDER_NAME
./easyrsa --batch build-client-full $FULL_CLIENT_CERTIFICATE_NAME nopass
cp pki/issued/$FULL_CLIENT_CERTIFICATE_NAME.crt $KEY_SAVE_FOLDER
cp pki/private/$FULL_CLIENT_CERTIFICATE_NAME.key $KEY_SAVE_FOLDER
cd $KEY_SAVE_FOLDER