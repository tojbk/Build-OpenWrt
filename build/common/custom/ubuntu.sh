#!/bin/bash
# SPDX-License-Identifier: GPL-3.0-only
#
# Copyright (C) ImmortalWrt.org

function Delete_useless(){
sudo apt-get update -y
if [[ "${SOURCE_CODE}" == "AMLOGIC" ]]; then
  echo "清理ubuntu无用插件,扩展空间"
  docker rmi `docker images -q`
  sudo -E apt-get -qq remove -y --purge azure-cli ghc* zulu* llvm* firefox google* powershell openjdk* msodbcsql17 mongodb* moby* snapd* mysql*
fi
sudo rm -rf /etc/apt/sources.list.d/* /usr/share/dotnet /usr/local/lib/android /usr/lib/jvm /opt/ghc /swapfile
}

function install_mustrelyon(){
# 安装我仓库需要的依赖
sudo apt-get install -y rename pigz libfuse-dev

# 安装天灵大佬的依赖
sudo bash -c 'bash <(curl -s https://build-scripts.immortalwrt.eu.org/init_build_environment.sh)'
}

function ophub_amlogic-s9xxx(){
# 安装打包N1需要用到的依赖
sudo apt-get install -y $(curl -fsSL https://is.gd/depend_ubuntu2204_openwrt) > /dev/null 2>&1
}

function update_apt_source(){
node --version
yarn --version

sudo apt-get autoremove -y --purge
sudo apt-get clean
}

function main(){
	if [[ -n "${BENDI_VERSION}" ]]; then
		INS="sudo apt-get"
		echo "开始升级ubuntu插件和安装依赖....."
		install_mustrelyon
		ophub_amlogic-s9xxx
		update_apt_source
	else
		INS="sudo -E apt-get -qq"
		Delete_useless
		install_mustrelyon
		ophub_amlogic-s9xxx
		update_apt_source
	fi
}

main
