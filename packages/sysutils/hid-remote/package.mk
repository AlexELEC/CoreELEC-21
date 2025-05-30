# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2011-present Alex@ELEC (https://alexelec.tv)

PKG_NAME="hid-remote"
PKG_VERSION="2.1.3"
PKG_SHA256="b03739f8eece7442e9d9e751a3d0d4dd0ea21443d4e2b3687a045655ffb9b6c7"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/AlexELEC/hid_mapper"
PKG_URL="${PKG_SITE}/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="A Generic HID mapper."
PKG_BUILD_FLAGS="-sysroot"

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/bin
    cp -p hid_mapper ${INSTALL}/usr/bin/hid-remote
    cp -p ${PKG_DIR}/scripts/* $INSTALL/usr/bin

  mkdir -p ${INSTALL}/usr/config/hid_remote
    cp -a ${PKG_DIR}/config/* ${INSTALL}/usr/config/hid_remote
}

post_install() {
  enable_service hid-remote.service
}
