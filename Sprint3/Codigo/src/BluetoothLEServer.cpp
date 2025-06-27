#include <BluetoothLEServer.hpp>

BluetoothLEServer::BluetoothLEServer(const char *name,
                                     volatile long int &flowCount,
                                     const int &volumePerCount) {
  this->flowCountPtr = &flowCount;
  this->volumePerCountPtr = &volumePerCount;

  BLEDevice::init(name);

  bleServer = BLEDevice::createServer();
  bleServer->setCallbacks(this);

  bleService = bleServer->createService(NUS_SERVICE_UUID);

  // TX: Notify characteristic (server -> client)
  txCharacteristic = bleService->createCharacteristic(
      NUS_CHAR_UUID_TX, BLECharacteristic::PROPERTY_NOTIFY);
  txCharacteristic->addDescriptor(new BLE2902());

  // RX: Write characteristic (client -> server)
  rxCharacteristic = bleService->createCharacteristic(
      NUS_CHAR_UUID_RX, BLECharacteristic::PROPERTY_WRITE);
  rxCharacteristic->setCallbacks(this);

  bleService->start();

  bleAdvertising = BLEDevice::getAdvertising();
  bleAdvertising->addServiceUUID(NUS_SERVICE_UUID);
  bleAdvertising->setScanResponse(true);
  bleAdvertising->setMinPreferred(0x06);
  bleAdvertising->setMinPreferred(0x12);
  BLEDevice::startAdvertising();
}

void BluetoothLEServer::notifyValue(const std::string &value) {
  if (!connected) {
    Serial.println(">>> No BLE client found. <<<");
    return;
  }

  txCharacteristic->setValue(value + "\n");
  txCharacteristic->notify();
  Serial.print(">> Sent: ");
  Serial.print(value.c_str());
  Serial.println(" <<");
}

void BluetoothLEServer::onConnect(BLEServer *pServer) {
  this->connected = true;
  Serial.println(">> BLE client connected <<");
  BLEDevice::stopAdvertising();
}

void BluetoothLEServer::onDisconnect(BLEServer *pServer) {
  this->connected = false;
  Serial.println(">> BLE client disconnected <<");
  BLEDevice::startAdvertising();
}

void BluetoothLEServer::onWrite(BLECharacteristic *pCharacteristic) {
  std::string rxValue = pCharacteristic->getValue();

  if (rxValue.empty()) {
    return;
  }

  int newVolume = (*this->flowCountPtr) * (*this->volumePerCountPtr);
  try {
    newVolume = std::stoi(rxValue);
  } catch (std::invalid_argument e) {
    Serial.println(e.what());
  } catch (std::out_of_range e) {
    Serial.println(e.what());
  }

  *this->flowCountPtr = newVolume * 1000 / (*this->volumePerCountPtr);
  Serial.println((">> Received: " + rxValue + " <<").c_str());
}

bool BluetoothLEServer::isConnected() { return this->connected; }