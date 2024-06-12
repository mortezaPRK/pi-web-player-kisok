#!/bin/bash

sudo sed -i 's/dtoverlay=vc4.*/dtoverlay=vc4-kms-v3d-pi4,cma-512,nohdmi1/g' /boot/firmware/config.txt && \
sudo sed -i 's/camera_auto_detect=1/dtoverlay=disable-bt/g' /boot/firmware/config.txt && \
sudo apt update && \
sudo apt dist-upgrade -y && \
sudo apt install -y \
    cage \
    cec-utils \
    chromium-browser \
    gstreamer1.0-libav \
    gstreamer1.0-plugins-bad \
    gstreamer1.0-plugins-base \
    gstreamer1.0-plugins-good \
    pulseaudio \
    pulseaudio-utils \
    rpi-chromium-mods \
    seatd \
    vim \
    uxplay \
    xwayland && \
sudo raspi-config && \
sudo mv /home/pi/backup/pi /etc/pam.d/pi && \
sudo mv /home/pi/backup/cage@.service /home/pi/backup/uxplay.service /home/pi/backup/cec-translate.service /home/pi/backup/ydotoold.service /etc/systemd/system/ && \
sudo mv /home/pi/backup/cec-translate /home/pi/backup/ydotoold /home/pi/backup/ydotool /home/pi/backup/chromium_launcher /home/pi/backup/cog_launcher /usr/local/bin/ && \
sudo systemctl daemon-reload && \
sudo systemctl enable cec-translate ydotoold cage@tty1.service uxplay.service && \
sudo systemctl set-default graphical.target && \
sudo reboot

