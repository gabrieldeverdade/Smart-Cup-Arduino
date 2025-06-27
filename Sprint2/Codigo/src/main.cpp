#include <Arduino.h>

#include <LiquidCrystalExtended.hpp>

// Maximumn duration in which the sensor receives signals
// otherwise no flow will be measured.
const static double loopDuration = 1000.0;     // 7.5s
const static double frequencyPrecision = 7.5;  // L / (min * Hz).

// Converts cicles into frequency (Hz).
const static double frequencyConstant = 1000.0 / loopDuration;
const static double mlPerCicle = 0.225;

// Water amount
volatile static int flowCicles = -1;
volatile static float volume = 0.0;

// Pins
const static unsigned int flowsensor = 2;
volatile unsigned long lastLoopTime = 0L;

// LCD settings
const static int address = 0x27;
const static int lcdColumns = 16;
const static int lcdRows = 2;
LiquidCrystalExtended lcd(address, lcdColumns, lcdRows);

void flowInterrupt() { ++flowCicles; }

void setup() {
  pinMode(flowsensor, INPUT);
  pinMode(flowsensor + 1, OUTPUT);
  pinMode(flowsensor - 1, OUTPUT);

  digitalWrite(flowsensor + 1, HIGH);
  digitalWrite(flowsensor - 1, LOW);

  Serial.begin(9600);

  lcd.init();
  attachInterrupt(digitalPinToInterrupt(flowsensor), flowInterrupt, RISING);

  lcd.println("Medidor de fluxo de agua");
  lcd.println("Trabalho Interdisciplinar V");
}

void loop() {
  const unsigned long currentTime = millis();
  Serial.println(digitalRead(flowsensor));
  if (currentTime - lastLoopTime < loopDuration) {
    return;
  }
  lcd.clear();

  double flowFrequency = flowCicles * frequencyConstant / 1000;
  double litersPerMinute = flowFrequency * frequencyPrecision / 1000;
  lcd.println(String("Fluxo: ") + String(litersPerMinute) + "L/min");

  volume += flowCicles * mlPerCicle;
  lcd.println(String("Volume: ") + String(volume) + "mL");

  lastLoopTime = millis();
  flowCicles = 0;
}