#!/bin/bash

set -e

BIN_DIR=/usr/local/bin
CODE_NAME=$(lsb_release -cs)
CEC_VERSION=0.1.1
SCRIPT_DIR=$(dirname $(realpath $0))
URL="https://github.com/mortezaPRK/cec-keyboard/releases/download/v${CEC_VERSION}/cec-keyboard_${CODE_NAME}_linux_amd64"

# check if user is root
if [ $EUID -ne 0 ]; then
    echo "This script must be run as root"
    exit 1
fi

# Dependencies
apt update
apt install -y \
    cec-utils \
    chromium-browser \
    gstreamer1.0-libav \
    gstreamer1.0-plugins-bad \
    gstreamer1.0-plugins-base \
    gstreamer1.0-plugins-good \
    rpi-chromium-mods \
    seatd \
    uxplay \
    wget

# Binaries
wget "$URL" -O $BIN_DIR/cec-keyboard
mv $SCRIPT_DIR/bin/chromium_launcher $BIN_DIR/
chmod +x $BIN_DIR/cec-keyboard $BIN_DIR/chromium_launcher

# Services
for service in $SCRIPT_DIR/services/*; do
    sed -i "s|<WD>|$SCRIPT_DIR|g" $service
    mv $service /etc/systemd/system/
done

systemctl daemon-reload
systemctl enable cec-keyboard.service cage@tty1.service uxplay.service httpd.service
systemctl set-default graphical.target

rm -r bin services init.sh
