#ifndef LIQUID_CRYSTAL_EXTENDED_HPP
#define LIQUID_CRYSTAL_EXTENDED_HPP

#include <LiquidCrystal_I2C.h>

class LiquidCrystalExtended : public LiquidCrystal_I2C {
 private:
  uint8_t _collumns;
  uint8_t _rows;
  uint8_t _nextRow = 0;

 public:
  LiquidCrystalExtended(uint8_t lcd_Addr, uint8_t lcd_cols, uint8_t lcd_rows);
  void println(const String content);
  void init();
};

#endif