#include <Arduino.h>
#include <BLE2902.h>
#include <BLEDevice.h>
#include <BLEServer.h>
#include <BLEUtils.h>

// Nordic UART Service UUIDs
#define NUS_SERVICE_UUID "6E400001-B5A3-F393-E0A9-E50E24DCCA9E"
#define NUS_CHAR_UUID_RX "6E400002-B5A3-F393-E0A9-E50E24DCCA9E"  // Write
#define NUS_CHAR_UUID_TX "6E400003-B5A3-F393-E0A9-E50E24DCCA9E"  // Notify

class BluetoothLEServer : public BLEServerCallbacks,
                          public BLECharacteristicCallbacks {
 private:
  BLEServer *bleServer;
  BLEService *bleService;
  BLECharacteristic *txCharacteristic;
  BLECharacteristic *rxCharacteristic;
  BLEAdvertising *bleAdvertising;
  volatile long int *flowCountPtr;
  const int *volumePerCountPtr;
  volatile bool connected = false;

 public:
  BluetoothLEServer(const char *name, volatile long int &flowCount,
                    const int &volumePerCount);

  void notifyValue(const std::string &value);

  void onConnect(BLEServer *pServer) override;

  void onDisconnect(BLEServer *pServer) override;

  void onWrite(BLECharacteristic *pCharacteristic) override;

  bool isConnected();
};