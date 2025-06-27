#include <Arduino.h>

#include "BluetoothSerial.h"

BluetoothSerial SerialBT;

const static double loopDuration = 1000.0;

volatile static long int flowCicles = 0;
volatile static int microLiterPerCicle = 2058;

volatile unsigned long lastLoopTime = 0L;

void flowInterrupt() { ++flowCicles; }

void setup() {
  Serial.begin(115200);
  SerialBT.begin("SmartCup");

  const static unsigned int flowsensor = 4;
  pinMode(flowsensor, INPUT);
  attachInterrupt(digitalPinToInterrupt(flowsensor), flowInterrupt, RISING);
}

void loop() {
  const unsigned long currentTime = millis();
  if (currentTime - lastLoopTime < loopDuration || !SerialBT.hasClient()) {
    return;
  }

  SerialBT.println(flowCicles * microLiterPerCicle / 1000);
  lastLoopTime = millis();
}
