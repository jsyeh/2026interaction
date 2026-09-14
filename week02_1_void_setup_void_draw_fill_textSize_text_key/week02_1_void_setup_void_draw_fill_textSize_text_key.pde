// week02_1_void_setup_void_draw_fill_textSize_text_key
// 鍵盤的操作, 與上週的 mouse 結合
// File-Preference 字型放大
void setup() {  // 設定的函式
  size(500, 500); // 視窗大小
}
void draw() {
  if (mousePressed) background(#F58A8A);
  else background(#F8CBFF); // 用 Tool-Color選擇器
  fill(0, 0, 255); // 藍色的填充色
  textSize(80); // 字的大小
  text("key: " + key, 200, 300); // 關注音輸入法, 才能收 key
}
