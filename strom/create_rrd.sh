/opt/rrdtool/bin/rrdtool create /var/strom/strom.rrd \
  --start now \
  --step 5s \
  DS:momentanLeistung:GAUGE:1m:0:U \
  DS:gesamtLeistung:GAUGE:30m:0:U \
  \
  RRA:MAX:0.5:5s:1w \
  RRA:MAX:0.5:1m:6M
