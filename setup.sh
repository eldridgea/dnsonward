### Takes env variables and generates Corefile

case $(uname -m) in  # Checks architecture and renames the appropriate binary
  *arm*) mv /coredns-arm /coredns
  ;;
  *x86_64*) mv /coredns-x86_64 /coredns
  ;;
esac

if [ -z $CACHE ]  # This section sets the default cache to 30s if none is provided
then
  CACHE=30s
fi

case $SERVICE in  # This section uses the preconfigured templates if $SERVICE is provided, otherwise configured based on $IP1, $IP2, and $SERVERNAME
  "cloudflare") cp cloudflare.template Corefile
  ;;
  "google") cp google.template Corefile
  ;;
  "quad9") cp quad9.template Corefile
  ;;
  "")
  cp Corefile.template Corefile
  sed -i "s/---IP1---/tls:\/\/$IP1/" Corefile
  sed -i "s/---IP2---/tls:\/\/$IP2/" Corefile
  sed -i "s/---SERVERNAME---/$SERVERNAME/" Corefile
  ;;
  *) echo "Unrecognized service provider, please use the IP and SERVERNAME options instead"; exit 1
esac

#Applies Cache to Corefile
sed -i "s/---CACHE---/$CACHE/" Corefile
