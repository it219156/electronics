// βαζω την βιβλιοθηκη του servo 
#include <Servo.h>. 
// θετω το trig στο 10 και το echo στο 11 
const int trigPin = 10;
const int echoPin = 11;
// Μεταβλητες για διαρκεια και αποσταση 
long duration;
int distance;
Servo myServo; // δημιουργω το servo αντικειμενο που θα χρησιμιμοποιει τον σενσορα 
void setup() {
  pinMode(trigPin, OUTPUT); // θετω το τριγ σαν output 
  pinMode(echoPin, INPUT); // θετω το εcho σαν input 
  Serial.begin(9600);//εναρξη σειριακης επικοινωνιας με ταχυτητα 9600 baud
  myServo.attach(12); // θετω το servo στο 12 
}
void loop() {
  // θετω το μοτερ να γυριζει απο 15 μοιρες εως 165 
  for(int i=15;i<=165;i++){  
  myServo.write(i);// ορισμος της γωνιας του servo 
  delay(30);// καθυστερω για να επιστρεψη το μοτερ στη θεση του 
  distance = ypologismosApostashs();// καλω την συναρτηση που υπλογιζει την αποσταση του sensor απο καθε τυχον αντικειμενο 
  
  Serial.print(i); // στελνει την αποσταση στο σειριακο μου ,εκτυπωση γωνιας 
  Serial.print(","); // Αυτο το κανω για το proccessing ,διαχωρισμος δεδομενων 
  Serial.print(distance); // στελνει την τιμη της αποστασης 
  Serial.print("."); // αυτο το κανω για το proccessing ,διαχωρισμος δεδομενων 
  }
  // κανει λοοπ τα προηγουμενα 
  for(int i=165;i>15;i--){  
  myServo.write(i);
  delay(30);
  distance = ypologismosApostashs();
  Serial.print(i);
  Serial.print(",");
  Serial.print(distance);
  Serial.print(".");
  }
}
// καλω τον υπολογισμο της αποστασης 
int ypologismosApostashs(){ 
  
  digitalWrite(trigPin, LOW); 
  delayMicroseconds(2);//το θετω να ξεκινησει σε χαμηλους ρυθμους 2 μικροδευτερολεπτα 
  // θετω το τριγ σε υψηλους ρυθμους 10 μικροδευτερολεπτα 
  digitalWrite(trigPin, HIGH); 
  delayMicroseconds(10);
  digitalWrite(trigPin, LOW);
  duration = pulseIn(echoPin, HIGH); // διαβαζω απο το echo και βγαζω τα αποτελεσματα ,οσο ειναι σε υψηλη κατασταση στελνει τα δεδομενα του σενσορ 
  distance= duration*0.034/2;// ο χρονος του ταξιδιου του υπερηχητικου σηματος (μικροδευτερολεπτα) πολλαπλασιαζεται με την ταχυτητα του ηχου του αερα και το διαιρω δια 2 για να βρω την αποσταση 
  return distance;//επιστρεφω την αποσταση 
}