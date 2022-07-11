################################################################################
#
# gst-variable-rtsp-server
#
################################################################################

GST_VARIABLE_RTSP_SERVER_VERSION = 490564815d8049dbdd79087f546835b673ba6e88
GST_VARIABLE_RTSP_SERVER_SITE = $(call github,Gateworks,gst-gateworks-apps,$(GST_VARIABLE_RTSP_SERVER_VERSION))
GST_VARIABLE_RTSP_SERVER_LICENSE = GPLv3
GST_VARIABLE_RTSP_SERVER_DEPENDENCIES = gst1-rtsp-server

define GST_VARIABLE_RTSP_SERVER_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) -C $(@D) all
endef

define GST_VARIABLE_RTSP_SERVER_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 0755 $(@D)/bin/gst-variable-rtsp-server $(TARGET_DIR)/usr/bin/gst-variable-rtsp-server
endef

$(eval $(generic-package))
