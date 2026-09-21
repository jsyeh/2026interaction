// week03_3_arduino_flow_LED
// LED 流動的感覺
void setup() {
  for (int i=2; i<=13; i++) pinMode(i, OUTPUT);  
} // 全部都可以發亮

void loop() {
  // 還沒寫完
  //for (int i=2; i<=13; i++) {
  for (int i=13; i>=2; i--) {
    for (int k=2; k<=13; k++) digitalWrite(k, LOW); // 全暗
    digitalWrite(i, HIGH); // 把 i 變亮
    delay(100); // 每一顆 LED 亮的時間
  }
}
