// week02_5_processing_do_re_mi_import_serial_myPort_void_keyPressed_write
// 我想要把 Arduino 跟 Processing 結合 
// 在 Processing 按下 key 1 2 3 對應 Arduino 的 Do Re Mi 使用 USB Serial
// 因為只有1條 USB Serial 線, 要記得按下「方塊」停止占用執行
import processing.serial.*; // 使用 USB Serial 外掛
Serial myPort; // 將用 myPort 來傳 USB Serial 資料
void setup() {
  size(300,200); // 隨便的視窗
  myPort = new Serial(this, "COM4", 9600); // 中間 "COM4" or "COM3" 自己查
}
void draw() {
  
}
void keyPressed() { // 按數字鍵時, 會利用 USB Serial 傳資料到 電路板
// 小心「注音輸入法」會吃掉你的 '1' '2' '3'
  if (key=='1') myPort.write('1');
  if (key=='2') myPort.write('2');
  if (key=='3') myPort.write('3');
}
