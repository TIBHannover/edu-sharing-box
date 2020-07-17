#!/bin/bash

# Script that generates the self-signed certificate for shibboleth service provider.

# Defaults. They can still be overridden by command-line options.
OUT=.
YEARS=3

me=`basename "$0"`

usage()
{
  echo "$me [-h hostname for cert (mandatory)] [-e entityID to embed in cert (mandatory)] [-o output directory (default .)] [-y years to issue cert (default 3)] [-n filename prefix (default 'shib-sp_<VALID_UNTIL>')] [-f force override existing files]"
}
while getopts h:e:o:y:n:f c
     do
         case $c in
           h)         FQDN=$OPTARG;;
           e)         ENTITYID=$OPTARG;;
           o)         OUT=$OPTARG;;
           y)         YEARS=$OPTARG;;
           n)         PREFIX=$OPTARG;;
           f)         FORCE=1;;
           \?)        usage
                      exit 1;;
         esac
     done

# check mandatory options   
if [ -z "$FQDN" ] || [ -z "$ENTITYID" ]; then
    echo "Missing mandatory options"
    usage
    exit 1
fi

if [ -z "$PREFIX" ]; then
    VALID_UNTIL=`date '+%Y' -d "+$YEARS years"`
    PREFIX="shib-sp_${VALID_UNTIL}"
fi
     
if [ -n "$FORCE" ] ; then
    rm $OUT/${PREFIX}-key.pem $OUT/${PREFIX}-cert.pem
fi

if  [ -s $OUT/${PREFIX}-key.pem -o -s $OUT/${PREFIX}-cert.pem ] ; then
    echo The files $OUT/${PREFIX}-key.pem and/or $OUT/${PREFIX}-cert.pem already exist!
    echo Use -f option to force recreation of keypair.
    exit 2
fi

DAYS=`expr $YEARS \* 365`

SSLCNF=$OUT/${PREFIX}-cert.cnf
cat >$SSLCNF <<EOF
# OpenSSL configuration file for creating keypair
[req]
default_bits=3072
default_md=sha256
encrypt_key=no
distinguished_name=dn
# PrintableStrings only
string_mask=MASK:0002
prompt=no
x509_extensions=ext
[dn]
CN=$FQDN
[ext]
subjectAltName = DNS:$FQDN,URI:$ENTITYID
subjectKeyIdentifier=hash
EOF

touch $OUT/${PREFIX}-key.pem
chmod 600 $OUT/${PREFIX}-key.pem
openssl req -config $SSLCNF -new -x509 -days $DAYS -keyout $OUT/${PREFIX}-key.pem -out $OUT/${PREFIX}-cert.pem
rm $SSLCNF
