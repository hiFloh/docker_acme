#LE_DOMAINS="storage.gapp-hsg.eu gitlab.gapp-hsg.eu onlyoffice.gapp-hsg.eu"
#LE_EMAIL="florian@gapp-hsg.eu"
DOMAINS=""
ARGS=""


function isEmail(){
  [[ "$1" =~ ^[^@\r\n\t\f\v\ ]{2,}@[^@\r\n\t\f\v\ ]{2,}\.[^@\r\n\t\f\v\ \.]{2,}$ ]]
}



if [[ $LE_ISNOTEST != 1 ]] 
then
 ARGS="$ARGS --test-cert"
 echo "using testcert"
fi


#if isEmail $LE_EMAIL 
#then
#  echo "email valid"
#else
#  exit -1
#fi

for dm in $LE_DOMAINS
do
  DOMAINS="$DOMAINS -d $dm"
done
echo $DOMAINS

if [[ $LE_EXPAND == 1 ]] 
then
  ARGS="$ARGS --expand"
fi
echo $ARGS



case "$LE_MODE" in
"webroot")
  MODE="--webroot -w /var/www/cert"
  if test -d "/var/www/cert/" 
  then
    echo "webroot exists"
  else
    exit -1
  fi
  ;;
"standalone")
  MODE="--standalone"
  ;;
esac
echo $LE_PREF_CHAIN
if [ -n "$LE_PREF_CHAIN" ]
then
  ARGS '$ARGS --preferred-chain "'$LE_PREF_CHAIN'"'
fi
  
letsencrypt certonly --non-interactive $ARGS -m $LE_EMAIL --agree-tos $MODE $DOMAINS

if [[ $LE_PFX == 1 ]]
then
  cd /etc/letsencrypt
  cpwd=$(pwd)
  for f in ./live/*; do
	  if [[ $f != "./live/README" ]]
	  then
		  echo $f;
		  cd $f;
		  openssl pkcs12 -export -out cert.pfx -inkey privkey.pem -in cert.pem -certfile chain.pem -passout pass:$PFX_PW
		  cd $cpwd
	  fi
  done
fi

