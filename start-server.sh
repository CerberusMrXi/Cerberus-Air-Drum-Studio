#!/bin/bash
echo "Cerberus Air Drum Studio"
echo "Open: http://localhost:8080/system/ads.html"
cd "$(dirname "$0")"
python3 -m http.server 8080
