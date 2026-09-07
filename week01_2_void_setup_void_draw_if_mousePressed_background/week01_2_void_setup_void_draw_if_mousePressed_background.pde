// week01_2_void_setup_void_draw_if_mousePressed_background
// 想要多點互動 (只是畫圖, 有點無聊)
void setup() { // 準備「設定」的函式, 做一次
  size(500, 500); // 視窗大小
}

void draw() { // 準備「畫圖」的函式,每秒60次
// 如果 mouse 按下去, 就讓背景紅色
  if (mousePressed) background(255, 0, 0); // 紅色
  else background(0, 255, 0); // 否則 綠色
}
