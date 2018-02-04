#pragma once

#include <QObject>

#include "ht2000.h"

#include <NSDev/DevicePluginInterface.h>
class DozerCalibrationDevicePluginInterface : public QObject, public DevicePluginInterface
{
    Q_OBJECT
    Q_PLUGIN_METADATA(IID "NSDev.DevicePluginInterface")
    Q_INTERFACES(DevicePluginInterface)

public:
    virtual void registerDeviceType(DeviceManager &dm)
    {
        dm.registerDeviceType<Ht2000Device>      ("ht2000",  "sensors/co2");
        dm.registerDeviceType<Ht2000Device>      ("ht2000",  "sensors/temperature");
        dm.registerDeviceType<Ht2000Device>      ("ht2000",  "sensors/humidity");
        qDebug() << "NsDevExtras library plugin was registered";
    }
};

