#LE_DOMAINS="storage.gapp-hsg.eu gitlab.gapp-hsg.eu onlyoffice.gapp-hsg.eu"
#LE_EMAIL="florian@gapp-hsg.eu"
DOMAINS=""
ARGS=""


function isEmail(){
  [[ "$1" =~ ^[^@\r\n\t\f\v\ ]{2,}@[^@\r\n\t\f\v\ ]{2,}\.[^@\r\n\t\f\v\ \.]{2,}$ ]]
}


if test -d "/var/www/cert/" 
then
  echo "webroot exists"
else
  exit -1
fi

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

letsencrypt certonly --non-interactive $ARGS -m $LE_EMAIL --agree-tos --webroot -w /var/www/cert $DOMAINS

