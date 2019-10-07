openssl speed -multi 16 md5 sha1 sha256 sha512 des des-ede3 aes-128-cbc aes-192-cbc aes-256-cbc rsa2048 dsa2048 | tee /tmp/sslspeed
echo "|" `awk 'match($0,/r[0-9]+/) {print substr($0,RSTART,RLENGTH)}' /etc/banner` `awk -v FS=": " -v ORS="" '/(Processor|BogoMIPS|Hardware|machine|cpu model|system type)/ { print "| " $2 " " } END { print "" }' /proc/cpuinfo` `awk -v ORS="" '$1 ~ /OpenSSL/ {print "| " $2 " |"} $1 ~ /(md5|sha)/ {print "  " $5 " |"} $1 ~ /(des|aes)/ {b = b "  " $6 " |"} $1 ~ /(rsa|dsa)/ {print b "  " $6 " | " $7 " ";b=""} END { print "|" }' /tmp/sslspeed | sed 's/\.\(..\)k/\10/g'`
echo 


stress-ng --cpu 16 --cpu-method fft --matrix 0 -t 60s --metrics-brief
stress-ng --cpu 16 --cpu-method pi --matrix 0 -t 60s --metrics-brief
