// week06_2_arduino_button_change_mode_LED_flow
int mode = 0; // 0:從小變到大, 1:從大變到小
void setup() {
  pinMode(2, INPUT_PULLUP);
  for (int i=3; i<=13; i++) {
    pinMode(i, OUTPUT); 
  }
  tone(8, 523, 100); delay(100); // Do  發個聲音, 提醒你程式有在動
  tone(8, 784, 100); delay(100); // Mi
}
int prev = HIGH, now = 3; // prev 是按鈕(前一瞬間)的狀態, now現在要發亮的LED
void loop() {
  if ( prev == HIGH && digitalRead(2) == LOW ) { // 按下去的瞬間
    if (mode==0) mode = 1; // 從0變1
    else mode = 0; // 從1變0
    prev = LOW; // 你可以把前面 tone() 的 Do Mi 放這裡
  } else if ( prev == LOW && digitalRead(2) == HIGH ) { // 放開的瞬間
    prev = HIGH;  // 你可以把前面 tone() 的 Mi D人 放這裡
  }
  if (mode==0) { // 0:從小變到大
    now++;
    if (now>13) now = 3; // 超過範圍, 又變回3
    digitalWrite(now, HIGH); // 亮
    delay(100); // 等一下
    digitalWrite(now, LOW); // 暗
  } else { // 1:從大變到小
    now--;
    if (now<3) now = 13;
    digitalWrite(now, HIGH); // 亮
    delay(100); // 等一下
    digitalWrite(now, LOW); // 暗
  } // 你也可以把重覆的 digitalWrite() delay() digitalWrite() 放在外面
}
