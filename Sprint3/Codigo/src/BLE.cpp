#include <Arduino.h>

#include <BluetoothLEServer.hpp>

BluetoothLEServer *bluetoothLEServer = nullptr;
const static double loopDuration = 1000.0;
volatile unsigned long lastLoopTime = 0L;

volatile static long int flowCicles = 0;
volatile static long int lastFlowCicle = 0;
const static int microLiterPerCicle = 2083;
void flowInterrupt() { ++flowCicles; }

void setup() {
  Serial.begin(115200);

  bluetoothLEServer = new BluetoothLEServer("SmartCup - TI V Grupo 3",
                                            flowCicles, microLiterPerCicle);

  const static unsigned int flowsensor = 4;
  pinMode(flowsensor, INPUT);
  attachInterrupt(digitalPinToInterrupt(flowsensor), flowInterrupt, RISING);
}

void loop() {
  const unsigned long currentTime = millis();
  if (currentTime - lastLoopTime < loopDuration || lastFlowCicle == flowCicles)
    return;

  int mL = flowCicles * microLiterPerCicle / 1000;
  bluetoothLEServer->notifyValue(std::to_string(mL));
  lastLoopTime = currentTime;
  lastFlowCicle = flowCicles;
}
