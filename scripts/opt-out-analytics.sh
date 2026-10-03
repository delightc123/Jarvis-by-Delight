#!/usr/bin/env bash
# Opt-out helper script: sets [analytics] enabled = false in ~/.openjarvis/config.toml

set -euo pipefail

CONFIG_DIR="${HOME}/.openjarvis"
CONFIG_FILE="${CONFIG_DIR}/config.toml"

mkdir -p "$CONFIG_DIR"

if [[ ! -f "$CONFIG_FILE" ]]; then
    cat << 'EOF' > "$CONFIG_FILE"
# Jarvis configuration
[analytics]
enabled = false
EOF
    echo "[ok] Created $CONFIG_FILE with [analytics] enabled = false"
    exit 0
fi

if grep -q '\[analytics\]' "$CONFIG_FILE"; then
    if grep -q -E '^\s*enabled\s*=' "$CONFIG_FILE"; then
        sed -i.bak -E '/\[analytics\]/,/^\[/ s/(enabled\s*=\s*)true/\1false/' "$CONFIG_FILE"
        rm -f "${CONFIG_FILE}.bak"
        echo "[ok] Updated [analytics] enabled = false in $CONFIG_FILE"
    else
        sed -i.bak -E 's/\[analytics\]/[analytics]\nenabled = false/' "$CONFIG_FILE"
        rm -f "${CONFIG_FILE}.bak"
        echo "[ok] Added enabled = false under [analytics] in $CONFIG_FILE"
    fi
else
    cat << 'EOF' >> "$CONFIG_FILE"

[analytics]
enabled = false
EOF
    echo "[ok] Appended [analytics] enabled = false to $CONFIG_FILE"
fi
