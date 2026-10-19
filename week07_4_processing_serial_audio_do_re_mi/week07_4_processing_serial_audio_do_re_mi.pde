// week07_4_processing_serial_audio_do_re_mi
// 修改自 week05_3_processing_do_re_mi_serial_draw
// 修改自 week07_3_processing_audio_do_re_mi (主要的程式)
import processing.serial.*;                // 加這行!!!
Serial myPort;                             // 加這行!!!
import processing.sound.*;
SoundFile Do, Re, Mi; // 有3個變數 Do Re Mi
void setup() {
  size(300, 200); 
  myPort = new Serial(this, "COM4", 9600); // 加這行!!!
  // 請把 do.wav re.wav mi.wav 共3個檔案,再一次拉到程式裡
  Do = new SoundFile(this, "do.wav");
  Re = new SoundFile(this, "re.wav");
  Mi = new SoundFile(this, "mi.wav");
}
void draw() {
  rect(0, 0, 100, 200);
  rect(100, 0, 100, 200);
  rect(200, 0, 100, 200);
}
void mousePressed() {
  if (mouseX < 100) {
    Do.play();
    myPort.write('1');                // 加這行!!!
  } else if (mouseX < 200) {
    Re.play();
    myPort.write('2');                // 加這行!!!
  } else if (mouseX < 300) {
    Mi.play();
    myPort.write('3');                // 加這行!!!
  }
}
void mouseReleased() {                // 加這行!!!
  myPort.write('0');                  // 加這行!!!
}
