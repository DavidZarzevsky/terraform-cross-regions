#!/usr/bin/env bash
set -x

KEY_SAVE_FOLDER_PATH=$KEY_SAVE_FOLDER
FULL_CLIENT_CERTIFICATE_NAME=$CLIENT_CERT_NAME.$TENANT_NAME
CLIENT_CERTIFICATE=$CLIENT_CERT_NAME.$CERT_ISSUER

aws ec2 export-client-vpn-client-configuration --client-vpn-endpoint-id $CLIENT_VPN_ID --profile $ENV --region $REGION --output text > $FULL_CLIENT_CERTIFICATE_NAME.ovpn

sed -i "s/"$CLIENT_VPN_ID"/"$TENANT_NAME.$CLIENT_VPN_ID"/g" $FULL_CLIENT_CERTIFICATE_NAME.ovpn
echo "<cert>" >> $FULL_CLIENT_CERTIFICATE_NAME.ovpn
cat $KEY_SAVE_FOLDER_PATH/client1.domain.tld.crt >> $FULL_CLIENT_CERTIFICATE_NAME.ovpn
echo "</cert>" >> $FULL_CLIENT_CERTIFICATE_NAME.ovpn

echo "<key>" >> $FULL_CLIENT_CERTIFICATE_NAME.ovpn
cat $KEY_SAVE_FOLDER_PATH/client1.domain.tld.key >> $FULL_CLIENT_CERTIFICATE_NAME.ovpn
echo "</key>" >> $FULL_CLIENT_CERTIFICATE_NAME.ovpn

smkdir -p ClientCertificates
mv $FULL_CLIENT_CERTIFICATE_NAME.ovpn ClientCertificates

