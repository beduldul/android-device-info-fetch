#!/system/bin/sh
# Android Device Information Diagnostic Utility

cat << "ART"
  ___            _roid 
 / _ \ _ __   __| |_ __ ___ (_) __| |
| | | | '_ \ / _` | '__/ _ \| |/ _` |
| |_| | | | | (_| | | | (_) | | (_| |
 \___/|_| |_|\__,_|_|  \___/|_|\__,_|
ART

echo "------------------------------------------"
echo " OS Version    : $(getprop ro.build.version.release) (SDK $(getprop ro.build.version.sdk))"
echo " Device Model  : $(getprop ro.product.model) ($(getprop ro.product.name))"
echo " Hardware      : $(getprop ro.board.platform)"
echo " Kernel        : $(uname -r)"
echo " Architecture  : $(uname -m)"
echo " CPU Governor  : $(cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor 2>/dev/null)"
echo " TCP Congestion: $(sysctl -n net.ipv4.tcp_congestion_control 2>/dev/null)"
echo " SELinux Mode  : $(getenforce 2>/dev/null)"
echo "------------------------------------------"
