#include <Wire.h>
#include <ros.h>
#include <std_msgs/Int16MultiArray.h>
#include <std_msgs/Int16.h>
#include <sensor_msgs/Range.h>

// Node initialisation
ros::NodeHandle nh;

int InA1 = 3; 
int InA2 = 2;
int enabA = 4; // Enable pin

int InB1 = 6; 
int InB2 = 5;
int enabB = 7; // Enable pin

int sonarAnalog = 0;

// subscriber callback , when new message comes this will be called by susbscriber
void PWM_CMD_R(const std_msgs::Int16& cmd_msg_R)
{ 
  int pwm_cmdr = cmd_msg_R.data; // right wheel speed

  
  // for RIGHTT side wheels,
  if (pwm_cmdr < 0)
  {
    analogWrite(InB1,0); 
    analogWrite(InB2,abs(pwm_cmdr));
    digitalWrite(enabB,HIGH); 
  }  
  else if (pwm_cmdr > 0) 
  {
    analogWrite(InB2,0);
    analogWrite(InB1,abs(pwm_cmdr)); 
    digitalWrite(enabB,HIGH); //writing pwm to motor
  }
  else 
  {
    analogWrite(InB1,0);
    analogWrite(InB2,0);
    digitalWrite(enabB,HIGH);
  }
}

void PWM_CMD_L(const std_msgs::Int16& cmd_msg_L)
{ 
  int pwm_cmdl = cmd_msg_L.data; // left wheel speed
  // for LEFT side wheels,
  if (pwm_cmdl > 0)
  { 
    analogWrite(InA1,0); 
    analogWrite(InA2,abs(pwm_cmdl));
    digitalWrite(enabA,HIGH); 
  }  
  else if (pwm_cmdl < 0) 
  {
    analogWrite(InA2,0);
    analogWrite(InA1,abs(pwm_cmdl)); 
    digitalWrite(enabA,HIGH); 
  }
  else
  {
    analogWrite(InA1,0);
    analogWrite(InA2,0);
    digitalWrite(enabA,HIGH); 
  }
}



ros::Subscriber<std_msgs::Int16> subR("pwm_cmd_r",PWM_CMD_R);
ros::Subscriber<std_msgs::Int16> subL("pwm_cmd_l",PWM_CMD_L);
ros::Subscriber<std_msgs::Int16> subencoReset("enco_rst",enco_CMD);


// Encoder Pin numbers and state and Encoder Reading
 
 // For the right encoder
 int enco_R_A = 29;
 int enco_R_B = 30;
 int enco_R_pos = 0;
 int enco_R_ALast = LOW;
 int enco_R_BLast = LOW;

 // For the left encoder
 int enco_L_A = 36;
 int enco_L_B = 35;
 int enco_L_pos = 0;
 int enco_L_ALast = LOW;
 int enco_L_BLast = LOW;
 

void enco_CMD(const std_msgs::Int16& val){
  enco_R_pos = 0;
  enco_L_pos = 0;
}

std_msgs::Int16 msg_R;
std_msgs::Int16 msg_L;
sensor_msgs::Range msg_sonar;
ros::Publisher sonar("sonar", &msg_sonar);
ros::Publisher enco_R("enco_R", &msg_R);
ros::Publisher enco_L("enco_L", &msg_L);

void updateSonar(){
  
}

void setup() 
{
  Serial.begin(57600);

  pinMode(enabA,OUTPUT);
  digitalWrite(enabA,LOW); 
  pinMode(InA1,OUTPUT);
  analogWrite(InA1,0);
  pinMode(InA2,OUTPUT);
  analogWrite(InA2,0);

  pinMode(enabB,OUTPUT);
  digitalWrite(enabB,LOW); 
  pinMode(InB1,OUTPUT);
  analogWrite(InB1,0);
  pinMode(InB2,OUTPUT);
  analogWrite(InB2,0);

  analogWriteFrequency(InA1,16000);
  analogWriteFrequency(InA2,16000);
  analogWriteFrequency(InB1,16000);
  analogWriteFrequency(InB2,16000);

  // Define pinmode for the pins reading encoder data
  pinMode (enco_R_A,INPUT);
  pinMode (enco_R_B,INPUT);
  pinMode (enco_L_A,INPUT);
  pinMode (enco_L_B,INPUT);
  pinMode (A6, INPUT);

  attachInterrupt(enco_R_A, doEncoder_R_A, CHANGE);
  attachInterrupt(enco_R_B, doEncoder_R_B, CHANGE);
  attachInterrupt(enco_L_A, doEncoder_L_A, CHANGE);
  attachInterrupt(enco_L_B, doEncoder_L_B, CHANGE);
  //attachInterrupt(A6, updateSonar, CHANGE);

  nh.initNode();
  
  nh.subscribe(subR);
  nh.subscribe(subL);
  nh.advertise(enco_R);
  nh.advertise(enco_L);
  nh.subscribe(subencoReset);
  nh.advertise(sonar);

  pinMode(13, OUTPUT);
  digitalWrite(13, HIGH);
}

void doEncoder_R_A() 
{
  // look for a low-to-high on channel A
  if (digitalRead(enco_R_A) == HIGH && enco_R_ALast == LOW) 
  {

    // check channel B to see which way encoder is turning
    if (digitalRead(enco_R_B) == LOW && enco_R_BLast == HIGH) {
      enco_R_pos = enco_R_pos + 1;         // CW
      enco_R_BLast = LOW;
    }
    else if (digitalRead(enco_R_B) == HIGH && enco_R_BLast == LOW){
      enco_R_pos = enco_R_pos - 1;         // CCW
      enco_R_BLast = HIGH;

    }
  }

  else if (digitalRead(enco_R_A) == LOW && enco_R_ALast == HIGH)   // must be a high-to-low edge on channel A
  {
    // check channel B to see which way encoder is turning
    if (digitalRead(enco_R_B) == HIGH && enco_R_BLast == LOW) {
      enco_R_pos = enco_R_pos + 1;          // CW
      enco_R_BLast = HIGH;
    }
    else if (digitalRead(enco_R_B) == LOW && enco_R_BLast == HIGH){
      enco_R_pos = enco_R_pos - 1;          // CCW
      enco_R_BLast = LOW;

    }
  }

  //msg_R.data = enco_R_pos;
  //msg_L.data = enco_L_pos;
  
  //enco_R.publish(&msg_R);
  //enco_L.publish(&msg_L);
  
  
  // use for debugging - remember to comment out
}

void doEncoder_R_B()
{
  // look for a low-to-high on channel B
  if (digitalRead(enco_R_B) == HIGH && enco_R_BLast == LOW) 
  {

    // check channel A to see which way encoder is turning
    if (digitalRead(enco_R_A) == HIGH && enco_R_ALast == LOW) 
    {
      enco_R_pos = enco_R_pos + 1;         // CW
      enco_R_ALast = HIGH;
    
    }
    else if (digitalRead(enco_R_A) == LOW && enco_R_ALast == HIGH)
    {
      enco_R_pos = enco_R_pos - 1;         // CCW
      enco_R_ALast = LOW;
   
    }
  }

  // Look for a high-to-low on channel B

  else if (digitalRead(enco_R_B) == LOW && enco_R_BLast == HIGH) {
    // check channel B to see which way encoder is turning
    if (digitalRead(enco_R_A) == LOW && enco_R_ALast == HIGH) 
    {
      enco_R_pos = enco_R_pos + 1;          // CW
      enco_R_ALast = LOW;

    }
    else if (digitalRead(enco_R_A) == HIGH && enco_R_ALast == LOW) 
    {
      enco_R_pos = enco_R_pos - 1;          // CCW
      enco_R_ALast = HIGH;
 
    }
  }

  //msg_R.data = enco_R_pos;
  //msg_L.data = enco_L_pos;
  
  //enco_R.publish(&msg_R);
  //enco_L.publish(&msg_L);
}

void doEncoder_L_A() 
{
  // look for a low-to-high on channel A
  if (digitalRead(enco_L_A) == HIGH && enco_L_ALast == LOW) 
  {

    // check channel B to see which way encoder is turning
    if (digitalRead(enco_L_B) == LOW && enco_L_BLast == HIGH) {
      enco_L_pos = enco_L_pos + 1;         // CW
       enco_L_BLast = LOW;

    }
    else if (digitalRead(enco_L_B) == HIGH && enco_L_BLast == LOW){
      enco_L_pos = enco_L_pos - 1;         // CCW
       enco_L_BLast = HIGH;
 
    }
  }

  else if (digitalRead(enco_L_A) == LOW && enco_L_ALast == HIGH)   // must be a high-to-low edge on channel A
  {
    // check channel B to see which way encoder is turning
    if (digitalRead(enco_L_B) == HIGH && enco_L_BLast == LOW) {
      enco_L_pos = enco_L_pos + 1;          // CW
      enco_L_BLast = HIGH;

    }
    else if (digitalRead(enco_L_B) == LOW && enco_L_BLast == HIGH){
      enco_L_pos = enco_L_pos - 1;          // CCW
      enco_L_BLast = LOW;
    
    }
  }
}

void doEncoder_L_B()
{
  // look for a low-to-high on channel B
  if (digitalRead(enco_L_B) == HIGH && enco_L_BLast == LOW) 
  {

    // check channel A to see which way encoder is turning
    if (digitalRead(enco_L_A) == HIGH && enco_L_ALast == LOW) 
    {
      enco_L_pos = enco_L_pos + 1;         // CW
      enco_L_ALast = HIGH;

    }
    else if (digitalRead(enco_L_A) == LOW && enco_L_ALast == HIGH)
    {
      enco_L_pos = enco_L_pos - 1;         // CCW
      enco_L_ALast = LOW;

    }
  }

  // Look for a high-to-low on channel B

  else if (digitalRead(enco_L_B) == LOW && enco_L_BLast == HIGH){
    // check channel B to see which way encoder is turning
    if (digitalRead(enco_L_A) == LOW && enco_L_ALast == HIGH) 
    {
      enco_L_pos = enco_L_pos + 1;          // CW
      enco_L_ALast = LOW;
      
    }
    else if (digitalRead(enco_L_A) == HIGH && enco_L_ALast == LOW)
    {
      enco_L_pos = enco_L_pos - 1;          // CCW
      enco_L_ALast = HIGH;

    }
  }
}

void loop()
{
  msg_R.data = enco_R_pos;
  msg_L.data = enco_L_pos;
  msg_sonar.range = analogRead(A6) / 0.0014168/1024;
  
  enco_R.publish(&msg_R);
  enco_L.publish(&msg_L);
  sonar.publish(&msg_sonar);
  
  nh.spinOnce();  

  delay(5);
}
