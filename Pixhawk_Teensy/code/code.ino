#define SERIAL_PORT_SPEED 9600
#define RC_NUM_CHANNELS  8

#define RC_CH1  0
#define RC_CH3  1

#define RC_CH1_INPUT  A7 // A7 is connected to pin 1 of Pixhawk
#define RC_CH3_INPUT  A8 // A8 is connected to pin 3 of Pixhawk
#define sonar A6
// Initial PWM
int pwm_cmdl = 0;
int pwm_cmdr = 0;

// pin connections from teensy to H-Bridge
int InA1 = 3; // IN1 on track A of H-Bridge
int InA2 = 2; // IN2 on track A of H-Bridge
int enabA = 4; // Enable pin on track B


int InB1 = 6; // IN1 on track B of H-Bridge
int InB2 = 5; // IN2 on track B of H-Bridge
int enabB = 7; // Enable pin on track B


// To store the PPM values coming out of the Pixhawk pins
uint16_t rc_values[RC_NUM_CHANNELS];
uint32_t rc_start[RC_NUM_CHANNELS];
volatile uint16_t rc_shared[RC_NUM_CHANNELS];

// Function to store the PPM values
void rc_read_values() {
  noInterrupts();
  memcpy(rc_values, (const void *)rc_shared, sizeof(rc_shared));
  interrupts();
}

// This function is called when the Interrupt condition is triggered
void calc_input(uint8_t channel, uint8_t input_pin) {
  if (digitalRead(input_pin) == HIGH) {
    rc_start[channel] = micros();
  } else {
    uint16_t rc_compare = (uint16_t)(micros() - rc_start[channel]);
    rc_shared[channel] = rc_compare;
  }
}

void calc_ch1() { calc_input(RC_CH1, RC_CH1_INPUT); }
void calc_ch3() { calc_input(RC_CH3, RC_CH3_INPUT); }


void setup() {
  Serial.begin(SERIAL_PORT_SPEED);

  pinMode(RC_CH1_INPUT, INPUT);
  pinMode(RC_CH3_INPUT, INPUT);

  attachInterrupt(RC_CH1_INPUT, calc_ch1, CHANGE);
  attachInterrupt(RC_CH3_INPUT, calc_ch3, CHANGE);

  // set motor initial conditions pwm is zero for both the motors
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

  analogWriteFrequency(InA1,20000);
  analogWriteFrequency(InA2,20000);
  analogWriteFrequency(InB1,20000);
  analogWriteFrequency(InB2,20000);
}

void loop() {
  rc_read_values();
//pwm_cmdl > 0 && pwm_cmdr > 0){ 
  

  if (rc_values[RC_CH1]>=1050 && rc_values[RC_CH1]<=1469)
  {
  pwm_cmdl = int(map(rc_values[RC_CH1], 1050, 1469, -255, -1)); // left wheel speed
  }
  else if (rc_values[RC_CH1]>=1471 && rc_values[RC_CH1]<=1890)
  {
  pwm_cmdl = int(map(rc_values[RC_CH1], 1471, 1890, 1, 255)); // left wheel speed
  }
  else
  {
   pwm_cmdl = int(0);
  }

  if (rc_values[RC_CH3]>=1050 && rc_values[RC_CH3]<=1469)
  {
  pwm_cmdr = int(map(rc_values[RC_CH3], 1050, 1469, -255, -1)); // right wheel speed
  }
  else if (rc_values[RC_CH3]>=1471 && rc_values[RC_CH3]<=1890)
  {
  pwm_cmdr = int(map(rc_values[RC_CH3], 1471, 1890, 1, 255)); // right wheel speed
  }
  else
  {
   pwm_cmdr = int(0);
  }
  
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

  // for RIGHT side wheels,
  if (pwm_cmdr < 0)
  {
    analogWrite(InB1,0); 
    analogWrite(InB2,abs(pwm_cmdl));
    digitalWrite(enabB,HIGH); 
  }  
  else if (pwm_cmdr > 0) 
  {
    analogWrite(InB2,0);
    analogWrite(InB1,abs(pwm_cmdl)); 
    digitalWrite(enabB,HIGH); //writing pwm to motor
  }
  else 
  {
    analogWrite(InB1,0);
    analogWrite(InB2,0);
    digitalWrite(enabB,HIGH);
  }
Serial.print("CH1:"); Serial.print(pwm_cmdl); Serial.println("\t");
  Serial.print("CH3:"); Serial.print(pwm_cmdr); Serial.println("\t");
  //int a = analogRead(sonar);
 // Serial.println(a);
  //delay(10);
}
