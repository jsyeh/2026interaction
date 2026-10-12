// week06_1_arduino_pin_2_button_INPUT_PULLUP
void setup() {
  pinMode(2, INPUT_PULLUP); // 預設 pin 2 是 Button
  pinMode(8, OUTPUT); // 預設 pin 8 是 Buzzer 喇叭
  tone(8, 523, 100); // 開啟時, 發一下聲音, 代表程式沒錯
} // 如果都不發聲音, 你可能會以為程式出錯、板子壞掉不會發聲音

void loop() {
  if ( digitalRead(2) == LOW ) {
    tone(8, 523, 100); // 0.1 秒
    delay(100); // 等一下(讓聲音夠長)
  }
}
