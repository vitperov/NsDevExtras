#pragma once

#include <QObject>

#include <NSDev/BaseDevice.h>

class Ht2000Device : public BaseDevice
{
    Q_OBJECT
public:
    Ht2000Device();

    bool initialise();
 };
