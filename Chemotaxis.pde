e[]obs;
int numof = 5;
int[]r = new int[numof];
int[]g = new int[numof];
int[]b = new int[numof];
boolean []alive = new boolean[numof];
int [] stx = new int[numof];
int [] sty = new int[numof];
int [] dir= new int[numof];
int count = 0;
int [] point = new int[numof];
boolean reset1 = false;
float acc0 = 100;
float acc = 100.0;
int milli = 0;
boolean acc1 = false;
int frames = 0;
int o =0;
float accF =0;
int add = 0 ;
int sz = 0;

void setup() {
  textSize(50);
  cursor(CROSS);
  textAlign(CENTER);
  size (1000, 1000);
  obs = new e[numof];
  for (int i=0; i < numof; i++) {
    stx[i] = (int)(Math.random()*501)+250;
    sty[i] = (int)(Math.random()*501)+150;
    obs[i] = new e(stx[i], sty[i]);
    r[i]=255;
    g[i]=0;
    b[i]=0;
    alive[i] = true;
    point[i] = 0;
    dir[i] = (int)(Math.random()*2);
  }
  frameRate (100);
  fill(255, 0, 0);
}
void draw() {
  if(numof==5){
    o=10;
  }
  if(numof==1){
    o=40;
  }
  background(0);
  fill (255);
  for (int i =0; i <numof; i++) {
    fill (r[i], g[i], b[i]);
    if (alive[i] == true) {
      obs[i].show(numof);
      obs[i].move(o);
      obs[i].hit(i);
      obs[i].wander(i);
    }
    if (g[i] >= 250) {
      alive[i] = false;
      if (point[i] ==0){
      count++;
      point[i] =1;}
    }
  }
  frames++;
    acc = acc0/frames;
    accF = Math.round(acc*100);
    accF = accF/100;
    fill(255);
    text("[e] reset", 500,780);
    textAlign(LEFT);
    text (add, 50, 200);
    textAlign(RIGHT);
    text (sz, 950, 200);
    textSize (30);
    textAlign(LEFT);
    text ("[w] increase speed", 50, 250);
    text ("[q] decrease speed", 50, 300);
    textAlign(RIGHT);
    text ("[s] increase size", 950, 250);
    text ("[q] decrease size", 950, 300);
    textAlign(CENTER);
    textSize (50);
    if(numof==1){
    text(count + " / 1", 200, 100);
    text(milli/1000.0, 500, 100);
    text(accF+" %", 800, 100);
    text("[1] change mode", 500,850);
  }
    if(numof==5){
    text(count + " / 5", 300, 100);
    text(milli/1000.0, 600, 100);
    text("[2] change mode", 500,850);
  }
    milli+=10;
    if (numof==count){
    end();
  }
}
class e {
  int myx, myy;
  e(int x, int y) {
    myx = x;
    myy = y;
  }
  void move(int o) {
    if ((myx<150+o && mouseX>myx)||(myy<150+o && mouseY>myy)||(myx>850-o && mouseX<myx)||(myy>850-o && mouseY<myy)) {
      if(dist(mouseX,mouseY,myx,myy)<100){
        if(myx<150+o && mouseX>myx){
          myx+=10+add;
        }
        if(myy<150+o && mouseY>myy){
          myy+=10+add;
        }
        if(myx>850-o && mouseX<myx){
          myx-=10-add;
        }
        if(myy>850-o && mouseX<myx){
          myy-=10-add;
        }
      }
      myx += (int)(Math.random()*3)-1;
      myy += (int)(Math.random()*3)-1;
    } else {
      if (dist(mouseX, mouseY, myx, myy)>100) {
        myx+=(int)(Math.random()*3)-1;
        myy+=(int)(Math.random()*3)-1;
      } else {
        if (mouseX >myx) {
          myx+=(int)(Math.random()*5)-4-add;
        }
        if (mouseX <myx) {
          myx+=(int)(Math.random()*5)+add;
        }
        if (mouseY >myy) {
          myy+=(int)(Math.random()*5)-4-add;
        }
        if (mouseY <myy) {
          myy+=(int)(Math.random()*5)+add;
        }
      }
    }
  }
  void show(int numof) {
    if(numof==5){ellipse (myx, myy, 50+sz, 50+sz);}
    if(numof==1){ellipse (myx, myy, 80+sz, 80+sz);}
    
  }
  void wander (int i) {
    if (dist(mouseX, mouseY, myx, myy)>100) {
      if (dir[i]== 0) {
        myx+=5+add;
        if (myx>850) {
          dir[i]=1;
        }
      }
      if (dir[i] == 1) {
        myx-=5+add;
        if (myx<150) {
          dir[i]=0;
        }
      }
    }
  }
  
 void hit(int i) {
    if (dist(mouseX, mouseY, myx, myy)<=40) {
      r[i]-=2;
      g[i]+=2;
      acc0+=100;
    }
  }
}
void end(){
  fill(0);
  rect(0,0,1000,1000);
  fill(255,0,0);
  textSize(100);
  text(milli/1000.0, 500,400);
  noFill();
  textSize(50);
  text ("[e] retry", 500,600);
  if(numof==1){
  text (accF+" %", 500,700);}
  noLoop();
 }
void reset(){
  add = 0;
  acc0=100;
  frames=0;
  count = 0;
  textSize(50);
  milli=0;
    for (int i=0; i < numof; i++) {
    stx[i] = (int)(Math.random()*501)+250;
    sty[i] = (int)(Math.random()*501)+150;
    obs[i] = new e(stx[i], sty[i]);
    r[i]=255;
    g[i]=0;
    b[i]=0;
    alive[i] = true;
    point[i] = 0;
    dir[i] = (int)(Math.random()*2);
  }
  fill(255, 0, 0);
  loop();
  redraw();
}
void keyPressed(){
  if (key == 'a'){
    sz-=5;
  }
  if (key =='s'){
    sz+=5;
  }
  if (key=='w'){
    add++;
    System.out.print(add);
  }
  if (key=='q'){
    add--;
    System.out.print(add);
  }
  if((key=='e')){
    reset();
    //System.out.print("1");
  }
  if (key == '2'){
    numof = 1;
    reset();
    acc1 = true;
  }
  if (key == '1'){
    numof=5;
    reset();
    acc1 = false;
  }
}
