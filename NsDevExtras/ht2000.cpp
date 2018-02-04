#include <map>
#include <QDebug>

#include "ht2000.h"

Ht2000Device::Ht2000Device()
	: BaseDevice()
{
}

bool Ht2000Device::initialise()
{
    return BaseDevice::initialise();
}
