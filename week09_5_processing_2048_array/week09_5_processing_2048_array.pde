// week09_5_processing_2048_array
// 修改自 week09_4_processing_2048_again
// 自己寫 2048 配上聲音, 慢慢來, 從簡單到完整
void setup() {
  size(550, 550);
}
// week09_5 多了陣列的宣告
int [][] a = { {0, 2, 0, 0}, {0, 0, 0, 0}, {0, 2, 2, 2}, {4, 4, 4, 4} };
void draw() {
  background(250, 248, 239); // 淡淡的背景色
  noStroke(); // 不要黑線
  fill(187, 173, 160); // 大格子的色彩
  rect(40, 40, 450, 450, 9); // 大格子
  for (int i=0; i<4; i++) { // 用迴圈,畫4x4格子
    for (int j=0; j<4; j++) {
      int x = 50 + j * (100+10);
      int y = 50 + i * (100+10); // 加點位移、間隔
      fill( tileColor(a[i][j]) ); // week09_5 改成呼叫 tileColor()函式查色彩
      //fill(238, 228, 218); // 小格子的色彩
      rect(x, y, 100, 100, 6);
    }
  }
}
int tileColor(int n) { // week09_5 這個函式, 是 week09_3 最後面拿來用的
  switch(n) {
    case 0:return color(205,193,180);
    case 2:return color(238,228,218);
    case 4:return color(237,224,200);
    case 8:return color(242,177,121);
    case 16:return color(245,149,99);
    case 32:return color(246,124,95);
    case 64:return color(246,94,59);
    case 128:return color(237,207,114);
    case 256:return color(237,204,97);
    case 512:return color(237,200,80);
    case 1024:return color(237,197,63);
    default:return color(237,194,46);
  }
}
