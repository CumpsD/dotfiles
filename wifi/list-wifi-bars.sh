#!/bin/bash
nmcli -f in-use,ssid,bssid,security,mode,chan,rate,signal,bars dev wifi list
