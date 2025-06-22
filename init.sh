#!/bin/bash

wget https://github.com/mortezaPRK/cec-keyboard/releases/download/v0.1.0/cec-keyboard_linux_arm64
mv cec-keyboard_linux_arm64 cec-keyboard
sudo sed -i 's/dtoverlay=vc4.*/dtoverlay=vc4-kms-v3d-pi4,cma-512,nohdmi1/g' /boot/firmware/config.txt && \
sudo sed -i 's/camera_auto_detect=1/dtoverlay=disable-bt/g' /boot/firmware/config.txt && \
sudo apt update && \
sudo apt dist-upgrade -y && \
sudo apt install -y \
    cec-utils \
    chromium-browser \
    gstreamer1.0-libav \
    gstreamer1.0-plugins-bad \
    gstreamer1.0-plugins-base \
    gstreamer1.0-plugins-good \
    rpi-chromium-mods \
    seatd \
    vim \
    uxplay && \
sudo mv /home/pi/backup/pi /etc/pam.d/pi && \
sudo mv /home/pi/backup/cage@.service /home/pi/backup/uxplay.service /home/pi/backup/cec-keyboard.service /etc/systemd/system/ && \
sudo mv /home/pi/cec-keyboard /home/pi/backup/chromium_launcher /usr/local/bin/ && \
sudo mv /home/pi/backup/cec-keyboard.yml /etc/
sudo systemctl daemon-reload && \
sudo systemctl enable cec-keyboard.service cage@tty1.service uxplay.service && \
sudo systemctl set-default graphical.target && \
sudo reboot

