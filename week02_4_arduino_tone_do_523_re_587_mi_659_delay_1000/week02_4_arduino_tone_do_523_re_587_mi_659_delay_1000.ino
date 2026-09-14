// week02_4_arduino_tone_do_523_re_587_mi_659_delay_1000
void setup() { // 設定的函式, 只做一次
  // put your setup code here, to run once:
  pinMode(8, OUTPUT);
  // 上面 setup()　只做一次
  tone(8, 523, 1000); // Do 1秒
  delay(1000);
  tone(8, 587, 1000); // Re 1秒
  delay(1000);
  tone(8, 659, 1000); // Mi 1秒
  delay(1000);
}

void loop() {
  // put your main code here, to run repeatedly:
  // 下面會一直迴圈重覆做、不會停
}
