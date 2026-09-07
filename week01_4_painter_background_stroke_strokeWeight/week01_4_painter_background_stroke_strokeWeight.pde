// week01_4_painter_background_stroke_strokeWeight
// (功能更多)小畫家
void setup() {
  size(500, 500);
  background(255); // 白色背景
  strokeWeight(5); // 筆畫的重量粗細
}

void draw() {
  if (mousePressed) { // mouse按下去, 有兩種可能
    if (mouseButton==LEFT) stroke(0); // 畫黑線
    if (mouseButton==RIGHT) stroke(255); // 用白色清掉
    line(mouseX, mouseY, pmouseX, pmouseY);
  }
}
