TEMPLATE = lib
TARGET = NsDevExtras

QT += core
CONFIG += c++11

INCLUDEPATH += $$(NS2_CORE_PATH)/external/include/
LIBS += -L$(NS2_CORE_PATH)/external/lib/

LIBS += -lNSDev

unix {
    LIBS += -L/usr/lib
}

linux-linaro-gnueabihf-g++ {
    QMAKE_CXXFLAGS += -Werror -Wno-error=strict-overflow -pg
    QMAKE_LFLAGS+=-pg

    QMAKE_CXXFLAGS_WARN_ON += -Wno-reorder
    LIBS += -L/usr/lib/arm-linux-gnueabihf/

    CONFIG(release, debug|release) {
        LIBS += -L$(NS2_CORE_PATH)/external/bin/arm-Release
        LIBS += -L$(NS2_CORE_PATH)/external/bin/arm-Release/devices
    } else {
        LIBS += -L$(NS2_CORE_PATH)/external/bin/arm-Debug
        LIBS += -L$(NS2_CORE_PATH)/external/bin/arm-Debug/devices
    }
}

linux-g++ {
    LIBS += -L/usr/local/lib
    LIBS += -L/usr/lib

    CONFIG(release, debug|release) {
        LIBS += -L$(NS2_CORE_PATH)/external/bin/x86-Release
        LIBS += -L$(NS2_CORE_PATH)/external/bin/x86-Release/devices
    } else {
        LIBS += -L$(NS2_CORE_PATH)/external/bin/x86-Debug
        LIBS += -L$(NS2_CORE_PATH)/external/bin/x86-Debug/devices
    }
}


SOURCES += \
    NsDevExtras/ht2000.cpp

HEADERS+= \
    NsDevExtras/ExtrasLibPlugin.h \
    NsDevExtras/ht2000.h \
    NsDevExtras/ExtrasPlugin.h

DEFINES += NSDEVEXTRAS_LIB
