#include <LiquidCrystalExtended.hpp>

LiquidCrystalExtended::LiquidCrystalExtended(uint8_t lcd_Addr, uint8_t lcd_cols,
                                             uint8_t lcd_rows)
    : LiquidCrystal_I2C(lcd_Addr, lcd_cols, lcd_rows) {
  this->_nextRow = 0;
  this->_rows = lcd_rows;
  this->_collumns = lcd_cols;
}

void LiquidCrystalExtended::init() {
  LiquidCrystal_I2C::init();
  this->backlight();
  this->clear();
}

void LiquidCrystalExtended::println(const String content) {
  this->setCursor(0, this->_nextRow);
  this->_nextRow = (this->_nextRow + 1) % this->_rows;
  this->print(content.substring(0, this->_collumns));
}
