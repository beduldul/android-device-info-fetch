#!/system/bin/sh
# Android Device Information Diagnostic Utility v1.1.0

# ANSI Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m'

cat << "ART"
  ___            _roid 
 / _ \ _ __   __| |_ __ ___ (_) __| |
| | | | '_ \ / _` | '__/ _ \| |/ _` |
| |_| | | | | (_| | | | (_) | | (_| |
 \___/|_| |_|\__,_|_|  \___/|_|\__,_|
ART

# Metrics Gathering
MEM_TOTAL=$(grep MemTotal /proc/meminfo | awk '{print int($2/1024)}')
MEM_AVAIL=$(grep MemAvailable /proc/meminfo | awk '{print int($2/1024)}')
MEM_USED=$((MEM_TOTAL - MEM_AVAIL))

BATT_TEMP=$(cat /sys/class/power_supply/battery/temp 2>/dev/null)
if [ -n "$BATT_TEMP" ]; then
    BATT_TEMP_C=$((BATT_TEMP / 10))°C
else
    BATT_TEMP_C="N/A"
fi

echo -e "${CYAN}------------------------------------------${NC}"
echo -e "${GREEN} OS Version    :${NC} $(getprop ro.build.version.release) (SDK $(getprop ro.build.version.sdk))"
echo -e "${GREEN} Device Model  :${NC} $(getprop ro.product.model) ($(getprop ro.product.name))"
echo -e "${GREEN} Hardware      :${NC} $(getprop ro.board.platform)"
echo -e "${GREEN} Kernel        :${NC} $(uname -r)"
echo -e "${GREEN} Architecture  :${NC} $(uname -m)"
echo -e "${YELLOW} RAM Usage     :${NC} ${MEM_USED}MB / ${MEM_TOTAL}MB"
echo -e "${YELLOW} Battery Temp  :${NC} ${BATT_TEMP_C}"
echo -e "${YELLOW} CPU Governor  :${NC} $(cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor 2>/dev/null)"
echo -e "${BLUE} TCP Congestion:${NC} $(sysctl -n net.ipv4.tcp_congestion_control 2>/dev/null)"
echo -e "${BLUE} SELinux Mode  :${NC} $(getenforce 2>/dev/null)"
echo -e "${CYAN}------------------------------------------${NC}"
