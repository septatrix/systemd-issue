#!/usr/bin/env sh

set -eux

# export SYSTEMD_LOG_LEVEL=debug
export SOURCE_DATE_EPOCH="0"

# copy from image -> a fails
systemd-repart \
    --no-pager \
    --empty=create \
    --size=55M \
    --root=rootfs-copy-block \
    --definitions=mkosi.repart/ \
    --seed=35ae3e3ad1694b47b0a6b3b8e65787f4 \
    --dry-run=no \
    image-copy \
&& sudo --preserve-env=SYSTEMD_LOG_LEVEL,SOURCE_DATE_EPOCH systemd-repart \
    --no-pager \
    --empty=create \
    --size=55M \
    --image=image-copy \
    --seed=35ae3e3ad1694b47b0a6b3b8e65787f4 \
    --dry-run=no \
    a-copy \
&& sudo --preserve-env=SYSTEMD_LOG_LEVEL,SOURCE_DATE_EPOCH systemd-repart \
    --no-pager \
    --empty=create \
    --size=55M \
    --image=a-copy \
    --seed=35ae3e3ad1694b47b0a6b3b8e65787f4 \
    --dry-run=no \
    b-copy
