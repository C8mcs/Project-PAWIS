#include <Servo.h>


// Define sensor pins for Inductive and Capacitive sensors
const int inductivePin1 = 2;
const int inductivePin2 = 3;
const int inductivePin3 = 4;

const int capacitivePin1 = 5;
const int capacitivePin2 = 6;
const int capacitivePin3 = 7;

const int soilMoisturePin1 = 8;
const int soilMoisturePin2 = 9;
const int soilMoisturePin3 = 10;

const int servoPin = 11;

int pos = 0;

int userPoints;

Servo binServo; // Create servo object

void setup() {
  Serial.begin(115200); // Serial communication with ESP8266
  binServo.attach(11); // Servo pin
  
  // Set pin modes for Inductive and Capacitive sensors
  pinMode(inductivePin1, INPUT);
  pinMode(inductivePin2, INPUT);
  pinMode(inductivePin3, INPUT);

  pinMode(capacitivePin1, INPUT);
  pinMode(capacitivePin2, INPUT);
  pinMode(capacitivePin3, INPUT);

  pinMode(soilMoisturePin1, INPUT);
  pinMode(soilMoisturePin2, INPUT);
  pinMode(soilMoisturePin3, INPUT);
}

void loop() {
  // Read sensor values
  bool isMetal1 = digitalRead(inductivePin1);
  bool isMetal2 = digitalRead(inductivePin2);
  bool isMetal3 = digitalRead(inductivePin3);

  bool isPlastic1 = digitalRead(capacitivePin1);
  bool isPlastic2 = digitalRead(capacitivePin2);
  bool isPlastic3 = digitalRead(capacitivePin3);

  int isWet1 = digitalRead(soilMoisturePin1);
  int isWet2 = digitalRead(soilMoisturePin2);
  int isWet3 = digitalRead(soilMoisturePin3);

  // Process sensor data
  processSensorData(1, isMetal1, isPlastic1, isWet1);
  processSensorData(2, isMetal2, isPlastic2, isWet2);
  processSensorData(3, isMetal3, isPlastic3, isWet3);

  // Send userPoints data over serial
  Serial.print("POINTS:");
  Serial.println(userPoints);

  delay(1000); // Adjust delay as necessary
}

void processSensorData(int setNumber, bool isMetal, bool isPlastic, bool isWet) {
  // Print sensor values for debugging
  Serial.print("Set ");
  Serial.print(setNumber);
  Serial.print(" - Metal: ");
  Serial.println(isMetal);
  Serial.print("Set ");
  Serial.print(setNumber);
  Serial.print(" - Plastic: ");
  Serial.println(isPlastic);
  Serial.print("Set ");
  Serial.print(setNumber);
  Serial.print(" - Moisture: ");
  Serial.println(isWet);

  // Determine waste type and move servo accordingly
  if (!isMetal && !isPlastic && !isWet) {
    Serial.println("Recyclable - No movement");
    moveServoToNeutral();
  } else if (!isMetal && !isPlastic && isWet) {
    Serial.println("Wet Waste - Rotate Left");
    moveServoLeft();
  } else if (!isMetal && isPlastic && !isWet) {
    Serial.println("Non-Biodegradable - Rotate Right");
    moveServoRight();
  } else if (!isMetal && isPlastic && isWet) {
    Serial.println("Non-Biodegradable - Rotate Right");
    moveServoRight();
  } else if (isMetal && !isPlastic && !isWet) {
    Serial.println("Non-Biodegradable - Rotate Right");
    moveServoRight();
  } else if (isMetal && !isPlastic && isWet) {
    Serial.println("Non-Biodegradable - Rotate Right");
    moveServoRight();
  } else if (isMetal && isPlastic && !isWet) {
    Serial.println("Non-Biodegradable - Rotate Right");
    moveServoRight();
  } else if (isMetal && isPlastic && isWet) {
    Serial.println("Non-Biodegradable - Rotate Right");
    moveServoRight();
  } else {
    Serial.println("Unknown Waste Type - No movement");
    moveServoToNeutral();
  } 

  pointSystem(setNumber, isMetal, isPlastic, isWet);
}

void pointSystem(int setNumber, bool isMetal, bool isPlastic, bool isWet)
{
  bool isCorrectBin = false;

  if((setNumber == 1 && !isMetal && !isPlastic && !isWet) || 
     (setNumber == 2 && !isMetal && !isPlastic && isWet) || 
     (setNumber == 3 && !isMetal && isPlastic && !isWet) ||
     (setNumber == 3 && !isMetal && isPlastic && isWet) || 
     (setNumber == 3 && isMetal && isPlastic && isWet) ||
     (setNumber == 3 && isMetal && !isPlastic && !isWet) || 
     (setNumber == 3 && isMetal && isPlastic && !isWet) ||
     (setNumber == 3 && isMetal && isPlastic && isWet))
  {
    isCorrectBin = true;
  } 

  if (isCorrectBin){
    userPoints++;
    Serial.println("Correct bin! You earned a point.");
  } else{
    Serial.println("Wrong bin! No point awarded.");
  }
  Serial.print("Points earned: ");
  Serial.println(userPoints);
}



// Function to move servo to neutral position (90 degrees)
void moveServoToNeutral() {
  for (pos = 0; pos <= 90; pos++)
  {
    binServo.write(90);
    delay(10);
  }
}

// Function to move servo to the right (135 degrees) and back to neutral
void moveServoRight() {
  for (pos = 90; pos <= 180; pos++)
  {
    binServo.write(pos);
    delay(10);
  }
  delay(2000);
  for (pos = 180; pos >= 90;pos--){
    binServo.write(pos);
  }
  delay(10);
}

// Function to move servo to the left (45 degrees) and back to neutral
void moveServoLeft() {
  for (pos = 90; pos >= 0; pos--)
  {
    binServo.write(pos);
    delay(10);
  }
  delay(2000);
  for (pos=0; pos<=90; pos++){
    binServo.write(pos);
    delay(10);
  }
  delay(10);
}

/*
void displayLCD()
{
  Serial.println("LCD display");
  lcd.setCursor(0,0);
  lcd.println("Total points: ");
  lcd.println(userPoints);
  delay(5000);
  lcd.clear();
}
*/
