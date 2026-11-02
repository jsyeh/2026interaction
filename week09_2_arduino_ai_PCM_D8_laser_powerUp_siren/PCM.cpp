// Experimental PCM output for Maker UNO pin D8 (ATmega328P 16 MHz).
// Uses Timer1 64 kHz interrupt and first-order pulse-density modulation.
#include <Arduino.h>
#include <avr/interrupt.h>
#include <avr/pgmspace.h>
#include "PCM.h"

static const uint8_t *audioData = nullptr;
static volatile uint16_t indexSample = 0;
static volatile uint16_t numSamples = 0;
static uint8_t subSample = 0;
static uint8_t level = 128;
static uint8_t integrator = 0;

ISR(TIMER1_COMPA_vect) {
  if (subSample == 0) {
    if (indexSample >= numSamples) {
      TIMSK1 &= ~_BV(OCIE1A);
      TCCR1B = 0;
      PORTB &= ~_BV(PB0);
      return;
    }
    level = pgm_read_byte(audioData + indexSample);
    ++indexSample;
  }
  uint8_t previous = integrator;
  integrator += level;
  // 8-bit overflow -> output one pulse; others output zero.
  if (integrator < previous) PORTB |= _BV(PB0);
  else PORTB &= ~_BV(PB0);
  subSample = (subSample + 1) & 7;
}

void startPlayback(const unsigned char *data, int length) {
  if (!data || length <= 0) return;
  uint8_t oldSREG = SREG;
  cli();
  TIMSK1 &= ~_BV(OCIE1A);
  TCCR1B = 0;
  DDRB |= _BV(DDB0); // Arduino D8 = PB0
  PORTB &= ~_BV(PB0);
  audioData = data;
  numSamples = (uint16_t)length;
  indexSample = 0;
  subSample = 0;
  level = 128;
  integrator = 0;
  // 16 MHz / (249+1) = 64,000 interrupts/sec;
  // one fresh PCM sample every 8 interrupts = 8,000 Hz.
  TCCR1A = 0;
  TCCR1B = _BV(WGM12);
  TCNT1 = 0;
  OCR1A = 249;
  TIFR1 = _BV(OCF1A);
  TIMSK1 |= _BV(OCIE1A);
  TCCR1B |= _BV(CS10);
  SREG = oldSREG;
}

void stopPlayback(void) {
  uint8_t oldSREG = SREG;
  cli();
  TIMSK1 &= ~_BV(OCIE1A);
  TCCR1B = 0;
  PORTB &= ~_BV(PB0);
  SREG = oldSREG;
}
