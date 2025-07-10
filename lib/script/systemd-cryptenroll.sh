#!/usr/bin/env bash

sudo systemd-cryptenroll --wipe-slot=tpm2 /dev/nvme0n1p2
sudo systemd-cryptenroll --tpm2-device=auto --tpm2-pcrs=0+7 /dev/nvme0n1p2
