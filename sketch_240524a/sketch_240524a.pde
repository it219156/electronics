import processing.serial.*; // κανω import την βιβλιοθηκη για επικοινωνια απο το σειριακο 
import java.awt.event.KeyEvent; // βιβλιοθηκη για να παρω τα δεδομενα 
import java.io.IOException;
Serial myPort; // τα κανει αντικειμενα 
// οι μεταβλητες που θα χρησιμοποιησω 
String angle="";
String distance="";
String data="";
String noObject;
float pixsDistance;
int iAngle, iDistance;
int index1=0;
int index2=0;
PFont orcFont;
void setup() {
  
 size (1750, 1000); // screen resolution 
 smooth();
 myPort = new Serial(this,"COM3", 9600); // ξεκιναω την επικοινωνια με το σειριακο 
 myPort.bufferUntil('.'); // διαβαζει το angle,distance 
}
void draw() {
  
  fill(98,245,31);
  // φτιαχνω την γραμμη να κινειται αργα 
  noStroke();
  fill(0,4); 
  rect(0, 0, width, height-height*0.065); 
  
  fill(98,245,31); // green color
  // καλω την συναρτηση απεικονισης του radar 
  drawRadar(); 
  drawGrammes();
  draw_antikeimeno();
  drawText();
}
void serialEvent (Serial myPort) { // διαβαζει απο το σειριακο 
  
  data = myPort.readStringUntil('.');
  data = data.substring(0,data.length()-1);
  
  index1 = data.indexOf(","); // διαβαζει , και το βαζει στο index1 
  angle= data.substring(0, index1); // διαβαζει το απο το 0 εως το , για να βαλει τις μοιρες 
  distance= data.substring(index1+1, data.length()); // αυτο ειναι για την αποσταση 
  
  // κανω το string int 
  iAngle = int(angle);
  iDistance = int(distance);
}
void drawRadar() {
  pushMatrix();
  translate(width/2,height-height*0.074); 
  noFill();
  strokeWeight(2);
  stroke(98,245,31);
  // φτιαχνω τις γραμμες του radar 
  arc(0,0,(width-width*0.0625),(width-width*0.0625),PI,TWO_PI);
  arc(0,0,(width-width*0.27),(width-width*0.27),PI,TWO_PI);
  arc(0,0,(width-width*0.479),(width-width*0.479),PI,TWO_PI);
  arc(0,0,(width-width*0.687),(width-width*0.687),PI,TWO_PI);
  // φτιαχνω τις γραμμες για τις μοιρες 
  line(-width/2,0,width/2,0);
  line(0,0,(-width/2)*cos(radians(30)),(-width/2)*sin(radians(30)));
  line(0,0,(-width/2)*cos(radians(60)),(-width/2)*sin(radians(60)));
  line(0,0,(-width/2)*cos(radians(90)),(-width/2)*sin(radians(90)));
  line(0,0,(-width/2)*cos(radians(120)),(-width/2)*sin(radians(120)));
  line(0,0,(-width/2)*cos(radians(150)),(-width/2)*sin(radians(150)));
  line((-width/2)*cos(radians(30)),0,width/2,0);
  popMatrix();
}
void draw_antikeimeno() {
  pushMatrix();
  translate(width/2,height-height*0.074); 
  strokeWeight(9);
  stroke(255,10,10); // κοκκινο 
  pixsDistance = iDistance*((height-height*0.1666)*0.025); // απο τα εκατοστα το μετατρεπω σε pixels πανω στο radar 
  // μεχρι 40 εκατοστα 
  if(iDistance<40){
    // αναπαριστα το αντικειμενο που ανιχνευθηκε 
  line(pixsDistance*cos(radians(iAngle)),-pixsDistance*sin(radians(iAngle)),(width-width*0.505)*cos(radians(iAngle)),-(width-width*0.505)*sin(radians(iAngle)));
  }
  popMatrix();
}
void drawGrammes() {
  pushMatrix();
  strokeWeight(9);
  stroke(30,250,60);
  translate(width/2,height-height*0.074); 
  line(0,0,(height-height*0.12)*cos(radians(iAngle)),-(height-height*0.12)*sin(radians(iAngle))); // θετω τις γραμμες συμφωνα με τις μοιρες
  popMatrix();
}
void drawText() { // αναπαριστω τα γραμματα κατω 
  pushMatrix();
  if(iDistance > 40) {
    noObject = "Out of Range";
  } else {
    noObject = "In Range";
  }
  fill(0, 0, 0);
  noStroke();
  rect(0, height - height * 0.0648, width, height);
  fill(98, 245, 31);
  textSize(25);
  
  text("10cm", width - width * 0.3854, height - height * 0.0833);
  text("20cm", width - width * 0.281, height - height * 0.0833);
  text("30cm", width - width * 0.177, height - height * 0.0833);
  text("40cm", width - width * 0.0729, height - height * 0.0833);
  textSize(40);
  text("chernobyl", width - width * 0.875, height - height * 0.0277);
  text("Angle: " + iAngle + " °", width - width * 0.58, height - height * 0.0277); // να στριβει αριστερα 
  
  // φτιαχνω το μεγεθος 
  textSize(40);
  fill(255, 0, 0); // κοκκινο 
  text("Distance: ", width - width * 0.36, height - height * 0.0277); 
  if(iDistance < 40) {
    text(iDistance + " cm", width - width * 0.15, height - height * 0.0277); 
  }
  textSize(25);
  fill(98, 245, 60);
  translate((width - width * 0.4994) + width / 2 * cos(radians(30)), (height - height * 0.0907) - width / 2 * sin(radians(30)));
  rotate(-radians(-60));
  text("30°", 0, 0);
  resetMatrix();
  translate((width - width * 0.503) + width / 2 * cos(radians(60)), (height - height * 0.0888) - width / 2 * sin(radians(60)));
  rotate(-radians(-30));
  text("60°", 0, 0);
  resetMatrix();
  translate((width - width * 0.507) + width / 2 * cos(radians(90)), (height - height * 0.0833) - width / 2 * sin(radians(90)));
  rotate(radians(0));
  text("90°", 0, 0);
  resetMatrix();
  translate(width - width * 0.513 + width / 2 * cos(radians(120)), (height - height * 0.07129) - width / 2 * sin(radians(120)));
  rotate(radians(-30));
  text("120°", 0, 0);
  resetMatrix();
  translate((width - width * 0.5104) + width / 2 * cos(radians(150)), (height - height * 0.0574) - width / 2 * sin(radians(150)));
  rotate(radians(-60));
  text("150°", 0, 0);
  popMatrix();
}
