#include <LiquidCrystal.h>

class LiquidCrystalExtended : public LiquidCrystal {
 private:
  uint8_t _collumns;
  uint8_t _rows;
  uint8_t _nextRow = 0;

 public:
  LiquidCrystalExtended(uint8_t rs, uint8_t en, uint8_t d4, uint8_t d5,
                        uint8_t d6, uint8_t d7)
      : LiquidCrystal(rs, en, d4, d5, d6, d7) {};

  void begin(uint8_t cols, uint8_t rows) {
    LiquidCrystal::begin(cols, rows);
    this->clear();

    this->_nextRow = 0;
    this->_rows = rows;
    this->_collumns = cols;

    this->println("Smart Cup - TI5");
    this->println("Grupo 3");
  };

  void println(const String content) {
    String truncated = content.substring(0, this->_collumns);
    this->setCursor(0, this->_nextRow);
    this->_nextRow = (this->_nextRow + 1) % this->_rows;
    this->print(truncated);
  };
};

// Maximumn duration in which the sensor has to receive signal
// otherwise no flow will be measured.
const static double loopDuration = 7500.0;
const static double frequencyPrecision = 7.5;  // L / (min * Hz).

// Converts cicles into frequency (Hz).
const static double frequencyConstant = 1000.0 / loopDuration;
const static int mlPerCicle = 125;

volatile static int flowCicles = 0;
volatile static float volume = 0.0;

const static int ledPin = 3;
const static int potenciometerPin = A5;
const static unsigned char flowsensor = 2;
volatile unsigned long lastInterruptionTime = 0L;
volatile unsigned long lastLoopTime = 0L;

LiquidCrystalExtended lcd(12, 11, 6, 5, 13, 10);

volatile double cicleCount = 0;
volatile bool reachedOne = false;

void flowInterrupt() {
  ++flowCicles;
  digitalWrite(ledPin, HIGH);
}

void setup() {
  pinMode(flowsensor, INPUT);
  pinMode(4, OUTPUT);
  Serial.begin(9600);
  pinMode(ledPin, OUTPUT);

  lcd.begin(16, 2);
  attachInterrupt(digitalPinToInterrupt(flowsensor), flowInterrupt, RISING);
}

void loop() {
  const unsigned long currentTime = millis();
  if (currentTime - lastInterruptionTime > 500) {
    int potenciometerRead = analogRead(potenciometerPin);
    int selectedFlow = map(potenciometerRead, 0, 1023, 0, 14);

    double selectedFlowFrequency = selectedFlow / 7.5;
    double ciclesSurpassed = selectedFlowFrequency * 0.5;
    if (cicleCount + ciclesSurpassed > 1.0) {
      digitalWrite(4, HIGH);
      reachedOne = true;
    }

    cicleCount = cicleCount + ciclesSurpassed > 1
                     ? cicleCount + ciclesSurpassed - 1
                     : cicleCount + ciclesSurpassed;
    lastInterruptionTime = millis();
    Serial.println(selectedFlow);
  } else {
    digitalWrite(4, LOW);
  }

  if (currentTime - lastLoopTime < loopDuration) {
    return;
  }

  if (!reachedOne) {
    cicleCount = 0;
  }

  double flowFrequency = flowCicles * frequencyConstant;
  double litersPerMinute = flowFrequency * frequencyPrecision;
  lcd.println(String("Fluxo: ") + String(litersPerMinute) + "L/min");

  volume += flowCicles * mlPerCicle;
  lcd.println(String("Vol: ") + String(volume) + "mL");

  lastLoopTime = millis();
  flowCicles = 0;
  digitalWrite(ledPin, LOW);
  reachedOne = false;
}
