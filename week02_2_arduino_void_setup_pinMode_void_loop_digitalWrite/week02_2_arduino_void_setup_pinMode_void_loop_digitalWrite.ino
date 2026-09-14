// week02_2_arduino_void_setup_pinMode_void_loop_digitalWrite
// 你的第1個 Arduino 的程式(會亮、會有聲音)
void setup() {
  // put your setup code here, to run once:
  pinMode(8, OUTPUT); // 第8個腳, 要發出 Buzzer 聲音
}
// 勾勾(Ctrl-R編譯程式) 箭頭往右(Ctrl-U上傳到電路板)
void loop() {
  // put your main code here, to run repeatedly:
  digitalWrite(8, HIGH); // 發出高電位
  delay(1000); // 等1秒 (1000ms = 1秒, 1ms = 0.001秒)
  digitalWrite(8, LOW); // 發出低電位
  delay(1000); // 等1秒 (1000很慢, 10很吵, 2有點聲音, 1音頻很高)
}
