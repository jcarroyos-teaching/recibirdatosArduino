import processing.serial.*;

Serial myPort;  // Create object from Serial class
String inputString = "";  // Data received from the serial port
float[] sensorValues = new float[13];  // Array to hold sensor values

void setup() {
  size(500, 800);  // Set the window size
  String portName = Serial.list()[1];  // Adjust index if necessary
  myPort = new Serial(this, portName, 9600);
  myPort.bufferUntil('\n');  // Read until a newline character
}

void draw() {
  background(0);  // Black background

  // Display sensor values
  fill(255);
  textSize(24);
  text("Sensor Data:", 10, 30);
  
  // Array of sensor names
  String[] sensorNames = {
    "Joystick X", "Joystick Y", "Light", "Temperature", "Slider", "Microphone", "Accel X", "Accel Y", "Accel Z", "Button 1", "Button 2", "Button 3", "Button 4"
  };

  float startY = 60;  // Starting y position for values
  float spacing = 30; // Space between lines

  for (int i = 0; i < sensorValues.length; i++) {
    text(sensorNames[i] + ": " + sensorValues[i], 10, startY + i * spacing);
  }
}

void serialEvent(Serial myPort) {
  String inString = myPort.readStringUntil('\n');
  if (inString != null) {
    inString = trim(inString);
    println("Received Data: " + inString);  // Print received data for debugging
    
    String[] values = split(inString, ',');
    if (values.length == 13) {
      for (int i = 0; i < values.length; i++) {
        sensorValues[i] = float(values[i]);
      }
    } else {
      println("Data format error. Expected 13 values, received: " + values.length);
      // Log the received data for further analysis
      println("Data: " + inString);
    }
  }
}
