################################################################################
#
# gst1-interpipe
#
################################################################################

GST1_INTERPIPE_VERSION = 814982ecd735e42ff2d14ce7c43039c259ec928b
GST1_INTERPIPE_SITE = https://github.com/RidgeRun/gst-interpipe
GST1_INTERPIPE_SITE_METHOD = git
# fetch gst-interpipe/common sub module
GST1_INTERPIPE_GIT_SUBMODULES = YES

GST1_INTERPIPE_LICENSE = LGPL-2.1
GST1_INTERPIPE_LICENSE_FILES = COPYING

# from git source
GST1_INTERPIPE_AUTORECONF = YES

GST1_INTERPIPE_DEPENDENCIES = host-pkgconf gstreamer1 gst1-plugins-base

$(eval $(autotools-package))
