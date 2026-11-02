// week09_3_processing_2048_serial_PCM
// Q6: 剛剛的 week09_1 week09_2 都成功了。接下來, 
// 想要試著用 Processing 寫個小遊戲(2048, 有方向鍵), 
// 再利用 USB 的 Serial 傳到 MakerUNO 發出對應的3個聲音(移動、消掉、跳出新的數字)。
// 你接到 "COM4" 就要寫 "COM4"
import processing.serial.*;

// week09_3 - 2048 + Maker UNO USB Serial PCM sound
// Change PORT_NAME to your actual Arduino port, e.g. "COM5" on Windows.
// Leave "" to try to select an Arduino-like port automatically.
final String PORT_NAME = "COM4"; // 這行, 要自己寫啊!!!!
final int BAUD = 115200;
Serial arduino;
String connection = "No serial";

int[][] board = new int[4][4];
int score = 0;
boolean won = false;
boolean over = false;
int lastMoveAt = -1000;
final int BOARD_X = 45, BOARD_Y = 155, CELL = 110, GAP = 10;

void settings() { size(550, 700); }

void setup() {
  surface.setTitle("2048 + Maker UNO D8 PCM Sound");
  textAlign(CENTER, CENTER);
  connectSerial();
  newGame();
}

void connectSerial() {
  if (arduino != null) {
    try { arduino.stop(); } catch (Exception e) { }
    arduino = null;
  }
  String[] ports = Serial.list();
  println("Available serial ports:");
  printArray(ports);
  String selected = PORT_NAME;
  if (selected.length() == 0) {
    for (String p : ports) {
      if (p.toLowerCase().indexOf("usbmodem") >= 0 ||
          p.toLowerCase().indexOf("usbserial") >= 0 ||
          p.toLowerCase().indexOf("ttyacm") >= 0 ||
          p.toLowerCase().indexOf("ttyusb") >= 0 ||
          p.toUpperCase().startsWith("COM")) { selected = p; break; }
    }
  }
  if (selected.length() == 0) {
    connection = "No port found - game works without sound";
    return;
  }
  try {
    arduino = new Serial(this, selected, BAUD);
    connection = "Serial: " + selected + " @ " + BAUD;
    println(connection);
  } catch (Exception e) {
    connection = "Port unavailable: " + selected;
    println(e);
  }
}

void newGame() {
  for (int r=0; r<4; r++) for (int c=0; c<4; c++) board[r][c]=0;
  score=0; won=false; over=false;
  spawnTile(false);
  spawnTile(false);
}

boolean spawnTile(boolean playSound) {
  int empty=0;
  for (int r=0;r<4;r++) for(int c=0;c<4;c++) if(board[r][c]==0) empty++;
  if (empty==0) return false;
  int target=int(random(empty));
  for (int r=0;r<4;r++) for(int c=0;c<4;c++) {
    if(board[r][c]==0) {
      if(target==0) {
        board[r][c] = random(1) < 0.9 ? 2 : 4;
        if(playSound) sendSound('N');
        return true;
      }
      target--;
    }
  }
  return false;
}

// direction: 0=left 1=right 2=up 3=down.
// Every line is read from the motion edge toward the opposite edge.
void moveBoard(int direction) {
  if (over || (won && !canContinueWin)) return;
  int[][] next = new int[4][4];
  boolean anyMerge = false;
  int gained=0;
  for (int line=0; line<4; line++) {
    int[] values=new int[4];
    int count=0;
    for (int k=0; k<4; k++) {
      int r=rowFor(direction,line,k), c=colFor(direction,line,k);
      if(board[r][c]!=0) values[count++]=board[r][c];
    }
    int[] packed=new int[4];
    int write=0;
    for (int k=0;k<count;k++) {
      if(k+1<count && values[k]==values[k+1]) {
        packed[write]=values[k]*2;
        gained += packed[write];
        anyMerge=true;
        k++;
      } else packed[write]=values[k];
      write++;
    }
    for (int k=0;k<4;k++) next[rowFor(direction,line,k)][colFor(direction,line,k)]=packed[k];
  }
  boolean changed=false;
  for (int r=0;r<4;r++) for (int c=0;c<4;c++) if(board[r][c]!=next[r][c]) changed=true;
  if(!changed) return; // No movement = no new tile or sound
  board=next;
  score += gained;
  sendSound('M'); // moved
  if (anyMerge) sendSound('C'); // merged one or more pairs
  spawnTile(true); // emits 'N'
  for (int r=0;r<4;r++) for(int c=0;c<4;c++) if(board[r][c]>=2048) won=true;
  over = !hasMoves();
}

boolean canContinueWin = true;
int rowFor(int d, int line, int k) {
  if(d==0 || d==1) return line;
  return (d==2) ? k : 3-k;
}
int colFor(int d, int line, int k) {
  if(d==0) return k;
  if(d==1) return 3-k;
  return line;
}
boolean hasMoves() {
  for(int r=0;r<4;r++) for(int c=0;c<4;c++) {
    if(board[r][c]==0) return true;
    if(r<3 && board[r][c]==board[r+1][c]) return true;
    if(c<3 && board[r][c]==board[r][c+1]) return true;
  }
  return false;
}

void sendSound(char event) {
  println("Sound event: " + event);
  if(arduino!=null) {
    try { arduino.write((int)event); }
    catch(Exception e) { connection="Serial write failed: press P to reconnect"; arduino=null; }
  }
}

void keyPressed() {
  if(key=='r' || key=='R') { newGame(); return; }
  if(key=='p' || key=='P') { connectSerial(); return; }
  if(key=='1') { sendSound('M'); return; }
  if(key=='2') { sendSound('C'); return; }
  if(key=='3') { sendSound('N'); return; }
  if(key==CODED) {
    if(keyCode==LEFT) moveBoard(0);
    else if(keyCode==RIGHT) moveBoard(1);
    else if(keyCode==UP) moveBoard(2);
    else if(keyCode==DOWN) moveBoard(3);
  }
}

void draw() {
  background(250, 248, 239);
  fill(119,110,101);
  textAlign(LEFT,CENTER);
  textSize(49);text("2048",45,62);
  textSize(20); text("Score: " + score,345,62);
  textSize(13);text("Arrow keys = move    R = restart    P = reconnect",46,113);
  textSize(12);text("1 = Move sound   2 = Merge   3 = New tile",46,133);
  noStroke();fill(187,173,160);rect(BOARD_X,BOARD_Y,460,460,9);
  textAlign(CENTER,CENTER);
  for(int r=0;r<4;r++) for(int c=0;c<4;c++) {
    int v=board[r][c];
    int x=BOARD_X+GAP+c*(CELL+0); // board interior: four 100px tiles + 10px gaps
    int y=BOARD_Y+GAP+r*CELL;
    fill(tileColor(v));rect(x,y,100,100,6);
    if(v>0) {
      fill(v<=4?color(119,110,101):color(249,246,242));
      textSize(v<128?34:v<1024?28:v<10000?23:18);
      text(str(v),x+50,y+48);
    }
  }
  fill(90,85,80);textSize(14);
  text(connection,275,637);
  if(over) { fill(80,60,40,220);rect(45,285,460,130,12);
    fill(255);textSize(35);text("GAME OVER",275,331);
    textSize(16);text("Press R to restart",275,379); }
  else if(won) {fill(40,130,80);textSize(13);text("2048 reached! Keep playing or press R",275,668);}
}

int tileColor(int n) {
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
