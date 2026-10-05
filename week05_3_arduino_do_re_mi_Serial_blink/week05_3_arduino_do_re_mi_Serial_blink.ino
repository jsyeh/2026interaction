// week05_3_arduino_do_re_mi_Serial_blink
// 修改自 week05_2_arduino_do_re_mi_Serial_tone_noTone
// 會有對應的燈號, 閃閃發亮
void setup() {
  pinMode(8, OUTPUT); // Buzzer 8 聲音
  pinMode(10, OUTPUT); // 對應 '0'
  pinMode(11, OUTPUT); // 對應 '1'
  pinMode(12, OUTPUT); // 對應 '2'
  pinMode(13, OUTPUT); // 對應 '3'

  Serial.begin(9600); // USB Serial 開始傳輸, 速度 9600 bps
  tone(8, 523, 100); delay(200); // Do
  tone(8, 587, 100); delay(200); // Re
  tone(8, 659, 100); delay(200); // Mi
  tone(8, 587, 100); delay(200); // Re
  tone(8, 523, 100); delay(200); // Do
}
char c = '0'; // 在外面宣告變數 0:不要發聲音 1:Do 2:Re 3:Mi
void loop() {
  if (Serial.available()){ // 如果 USB Serial 有收到資料
    c = Serial.read(); // 就讀進來 (不要再宣告變數char c, 直接寫 c)
  }
  for (int i=10; i<=13; i++) digitalWrite(i, LOW); // 先都暗下來
  if (c>='0' && c<='3') digitalWrite(c-'0'+10, HIGH); // 大小寫換算
  if (c=='0') noTone(8); // 不要發聲音
  if (c=='1') tone(8, 523); // Do 一直發聲音 (不要限定 100ms)
  if (c=='2') tone(8, 587); // Re 一直發聲音
  if (c=='3') tone(8, 659); // Mi 一直發聲音
}
