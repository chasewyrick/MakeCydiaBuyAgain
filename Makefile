GO_EASY_ON_ME = 1

ARCHS = arm64

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = MakeCydiaBuyAgain
$(TWEAK_NAME)_FILES = Tweak.xm
$(TWEAK_NAME)_FRAMEWORKS = UIKit

include $(THEOS_MAKE_PATH)/tweak.mk


after-install::
	install.exec "killall -9 Cydia"
