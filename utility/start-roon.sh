#!/bin/bash

pulseaudio --kill
systemctl restart roonbridge
systemctl status roonbridge
