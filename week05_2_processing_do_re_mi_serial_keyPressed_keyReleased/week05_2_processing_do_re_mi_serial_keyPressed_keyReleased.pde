// week05_2_processing_do_re_mi_serial_keyPressed_keyReleased
// 修改自 week05_1_processing_do_re_mi_serial
// 按多久、叫多久, 放開、就不叫了 不是永遠 0.1 秒
import processing.serial.*; // 使用 USB Serial 外掛
Serial myPort; // 將用 myPort 來傳 USB Serial 資料
void setup() {
  size(300,200); // 隨便的視窗
  myPort = new Serial(this, "COM4", 9600); // 中間 "COM4" or "COM3" 自己查
}
void draw() {
  
}
int p1 = 0, p2 = 0, p3 = 0; // 變數記錄按鍵,一開始沒按, 下面做修改
void keyPressed() {
  if (p1==0 && key=='1') myPort.write('1'); // 之前沒按, 現在按
  if (p2==0 && key=='2') myPort.write('2'); 
  if (p3==0 && key=='3') myPort.write('3');
  if (p1==0 && key=='1') p1 = 1; // 0代表「沒有按」1代表「按下去」
  if (p2==0 && key=='2') p2 = 1;
  if (p3==0 && key=='3') p3 = 1;
}
void keyReleased() {
  if (key=='1') p1 = 0; // 放開 1 鍵
  if (key=='2') p2 = 0; // 放開 2 鍵
  if (key=='3') p3 = 0; // 放開 3 鍵
  myPort.write('0'); // 告訴 Arduino 你不要發出任何聲音!!!!!
}
