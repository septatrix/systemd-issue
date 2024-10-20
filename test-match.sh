#!/usr/bin/env sh

set -eux

# export SYSTEMD_LOG_LEVEL=debug
export SOURCE_DATE_EPOCH="0"

# hash changes from image -> a, and copy from a -> b fails
systemd-repart \
    --no-pager \
    --empty=create \
    --size=55M \
    --root=rootfs-match-key \
    --definitions=mkosi.repart/ \
    --seed=35ae3e3ad1694b47b0a6b3b8e65787f4 \
    --dry-run=no \
    image-match \
&& sudo --preserve-env=SYSTEMD_LOG_LEVEL,SOURCE_DATE_EPOCH systemd-repart \
    --no-pager \
    --empty=create \
    --size=55M \
    --image=image-match \
    --seed=35ae3e3ad1694b47b0a6b3b8e65787f4 \
    --dry-run=no \
    a-match \
&& sudo --preserve-env=SYSTEMD_LOG_LEVEL,SOURCE_DATE_EPOCH systemd-repart \
    --no-pager \
    --empty=create \
    --size=55M \
    --image=a-match \
    --seed=35ae3e3ad1694b47b0a6b3b8e65787f4 \
    --dry-run=no \
    b-match
