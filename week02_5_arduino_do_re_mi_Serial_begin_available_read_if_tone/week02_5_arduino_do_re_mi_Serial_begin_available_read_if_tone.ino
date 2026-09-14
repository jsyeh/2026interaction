// week02_5_arduino_do_re_mi_Serial_begin_available_read_if_tone
// google: 我想要把 Arduino 跟 Processing 結合 
// 在 Processing 按下 key 1 2 3 對應 Arduino 的 Do Re Mi 使用 USB Serial
// 寫完程式, 用 工具Tool-序列埠監控視窗SerialMonitor 來傳送 1 2 3 測試很麻煩
// 因為只有1條 USB Serial 線, 要記得關掉 Serial Monitor
void setup() {
  Serial.begin(9600); // USB Serial 開始傳輸, 速度 9600 bps
}

void loop() {
  if (Serial.available()){ // 如果 USB Serial 有收到資料
    char c = Serial.read(); // 就讀進來
    if (c=='1') tone(8, 523, 100); // Do 1秒
    if (c=='2') tone(8, 587, 100); // Re 1秒
    if (c=='3') tone(8, 659, 100); // Mi 1秒
  }
}
