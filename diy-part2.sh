#!/bin/bash
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#
# Copyright (c) 2019-2024 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#

set -euo pipefail

# Modify default IP
#sed -i 's/192.168.1.1/192.168.50.5/g' package/base-files/files/bin/config_generate

# Modify default theme
#sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/collections/luci/Makefile

# Modify hostname
#sed -i 's/OpenWrt/P3TERX-Router/g' package/base-files/files/bin/config_generate

# Replace the bundled OpenClash with the fork, pinned to a commit
# so builds are reproducible. Update the pin deliberately, not
# implicitly on every build.
OPENCLASH_COMMIT="1c8ccbb5016cd0931703fb06bf1ae171e1409d37"
OPENCLASH_DIR="feeds/luci/applications/luci-app-openclash"

if [ -d "$OPENCLASH_DIR" ]; then
  rm -rf "$OPENCLASH_DIR"
fi
git clone --depth 1 https://github.com/tojbk/luci-app-openclash "$OPENCLASH_DIR"
git -C "$OPENCLASH_DIR" checkout "$OPENCLASH_COMMIT"
git -C "$OPENCLASH_DIR" rev-parse HEAD
