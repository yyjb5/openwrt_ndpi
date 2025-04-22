#
# ndpiReader OpenWrt Makefile
#

include $(TOPDIR)/rules.mk

PKG_NAME:=ndpiReader
PKG_VERSION:=4.6
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://github.com/ntop/nDPI.git
PKG_SOURCE_VERSION:=refs/tags/$(PKG_VERSION)
PKG_MIRROR_HASH:=skip

PKG_BUILD_DIR:=$(BUILD_DIR)/nDPI-$(PKG_VERSION)

include $(INCLUDE_DIR)/package.mk

define Package/ndpiReader
  SECTION:=net
  CATEGORY:=Network
  TITLE:=nDPI Reader CLI tool
  DEPENDS:=+libpcap +libpthread +libstdcpp
endef

define Package/ndpiReader/description
  CLI tool to analyze network traffic using nDPI.
endef

MAKE_FLAGS += \
  CFLAGS="$(TARGET_CFLAGS)" \
  LDFLAGS="$(TARGET_LDFLAGS)" \
  -C $(PKG_BUILD_DIR)/example

define Build/Compile
	$(MAKE) -C $(PKG_BUILD_DIR)/example ndpiReader
endef

define Package/ndpiReader/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/example/ndpiReader $(1)/usr/bin/
endef

$(eval $(call BuildPackage,ndpiReader))
