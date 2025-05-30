# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2019-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="wireguard-tools"
PKG_VERSION="1.0.20210914"
PKG_SHA256="69de713458a887cddb46b2fd1d43bf20548f693136af95792e65ec925538c770"
PKG_LICENSE="GPLv2"
PKG_SITE="https://www.wireguard.com"
PKG_URL="https://git.zx2c4.com/wireguard-tools/snapshot/wireguard-tools-v${PKG_VERSION}.tar.xz"
PKG_DEPENDS_TARGET="toolchain linux"
PKG_NEED_UNPACK="${LINUX_DEPENDS}"
PKG_LONGDESC="WireGuard VPN userspace tools"
PKG_TOOLCHAIN="manual"
PKG_IS_KERNEL_PKG="yes"

make_target() {
  kernel_make KERNELDIR=$(kernel_path) -C src/ wg
}

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/bin
  cp ${PKG_DIR}/scripts/* ${INSTALL}/usr/bin
  cp -R ${PKG_DIR}/config ${INSTALL}/usr

  cp ${PKG_BUILD}/src/wg ${INSTALL}/usr/bin
}

post_install() {
  # install service for wg0.conf configuration file
  ln -s ../wg-quick@.service \
    ${INSTALL}/usr/lib/systemd/system/multi-user.target.wants/wg-quick@wg0.service
}
