#!/bin/bash

# Colors
RED='\033[0;31m'
YELLOW='\033[1;33m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m'

if ! ip link show 2>/dev/null | grep -q "proton"; then
    echo -e "${RED}VPN not connected${NC}"
    exit 1
fi

echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${GREEN}   VPN SPEED TEST${NC}"
echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""

echo -e "${BLUE}Current Server:${NC}"
curl -s --max-time 3 ifconfig.me
echo ""
echo ""

echo -e "${BLUE}Download Test (10MB):${NC}"
result=$(curl -o /dev/null -w "Speed: %{speed_download}\nTime: %{time_total}" \
    --max-time 30 \
    https://speed.cloudflare.com/__down?bytes=10000000 2>/dev/null)

speed=$(echo "$result" | grep Speed | awk '{print $2}')
time=$(echo "$result" | grep Time | awk '{print $2}')

if [ -n "$speed" ]; then
    mb_speed=$(echo "scale=2; $speed / 1000000" | bc)
    echo -e "  Speed: ${GREEN}${mb_speed} MB/s${NC}"
    echo -e "  Time: ${time}s"
    echo ""
    
    # Overall rating
    if (( $(echo "$speed > 5000000" | bc -l) )); then
        echo -e "${GREEN}Rating: ★★★★★ EXCELLENT${NC}"
    elif (( $(echo "$speed > 2000000" | bc -l) )); then
        echo -e "${GREEN}Rating: ★★★★☆ GOOD${NC}"
    elif (( $(echo "$speed > 500000" | bc -l) )); then
        echo -e "${YELLOW}Rating: ★★★☆☆ OK${NC}"
    else
        echo -e "${RED}Rating: ★★☆☆☆ POOR - Consider switching regions${NC}"
    fi
else
    echo -e "${RED}Test failed${NC}"
fi
