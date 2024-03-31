#!/usr/bin/env sh

set -eux

export SOURCE_DATE_EPOCH="0"

touch image-match a-match b-match

# hash changes from image -> a, and copy from a -> b fails
systemd-repart \
    --no-pager \
    --empty=force \
    --size=55M \
    --root=rootfs-match-key \
    --definitions=mkosi.repart/ \
    --seed=35ae3e3ad1694b47b0a6b3b8e65787f4 \
    --dry-run=no \
    image-match \
&& sudo --preserve-env=SYSTEMD_LOG_LEVEL,SOURCE_DATE_EPOCH systemd-repart \
    --no-pager \
    --empty=force \
    --size=55M \
    --image=image-match \
    --dry-run=no \
    a-match \
&& sudo --preserve-env=SYSTEMD_LOG_LEVEL,SOURCE_DATE_EPOCH systemd-repart \
    --no-pager \
    --empty=force \
    --size=55M \
    --image=a-match \
    --dry-run=no \
    b-match \
|| true

touch image-copy a-copy b-copy

# copy from image -> a fails
systemd-repart \
    --no-pager \
    --empty=force \
    --size=55M \
    --root=rootfs-copy-block \
    --definitions=mkosi.repart/ \
    --seed=35ae3e3ad1694b47b0a6b3b8e65787f4 \
    --dry-run=no \
    image-copy \
&& sudo --preserve-env=SYSTEMD_LOG_LEVEL,SOURCE_DATE_EPOCH systemd-repart \
    --no-pager \
    --empty=force \
    --size=55M \
    --image=image-copy \
    --dry-run=no \
    a-copy \
&& sudo --preserve-env=SYSTEMD_LOG_LEVEL,SOURCE_DATE_EPOCH systemd-repart \
    --no-pager \
    --empty=force \
    --size=55M \
    --image=a-copy \
    --dry-run=no \
    b-copy
