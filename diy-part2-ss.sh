#!/bin/bash
# Description: OpenWrt DIY script part 2 (After Update feeds)
# 经过 2026 现代化审计提纯版本

# 1. 修改默认管理 IP (保持你的习惯)
sed -i 's/192.168.1.1/192.168.1.10/g' package/base-files/files/bin/config_generate

# 2. 修改主机名为 AlexWRT
sed -i "s/hostname='.*'/hostname='AlexWRT'/g" package/base-files/files/bin/config_generate

# 3. 修正最大并发连接数（提升多设备与挂机环境的 NAT 吞吐抗压能力）
sed -i '/customized in this file/a net.netfilter.nf_conntrack_max=165535' package/base-files/files/etc/sysctl.conf

# 4. 加入常用好评的第三方独立插件 (保留了体积小且仍维护的有用工具)
# DNS 过滤去广告
git clone https://github.com/kiddin9/luci-app-dnsfilter.git package/luci-app-dnsfilter
# IPTV 助手（如果是家庭内部网络且涉及 VLAN 配置，此插件依然有辅助价值）
git clone https://github.com/riverscn/openwrt-iptvhelper.git package/openwrt-iptvhelper

# 备注：AdGuardHome, SmartDNS 等大型插件建议直接在云端 make menuconfig 时
# 从内置的 LuCI -> Applications 列表中勾选官方维护的版本，不要在此处外挂拉取。
