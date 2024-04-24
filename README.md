# Smart Parking System with Ultrasonic Sensors
* [Theoretical description and explanation](#theoretical-description-and-explanation)
* [Hardware description of demo application](#hardware-description-of-demo-application)
* [Software description](#software-description)
* [Instructions](#instructions)

  

### Team members
Member 1: Marek Karlíček <br/>
Member 2: Tomáš Kučera <br/>
Member 3: Jan Kříž <br/>
Member 4: Rauf Iusupov <br/>
## Theoretical description and explanation
Smart car parking system is designed to facilitate parking by providing information about the vehicle's distance from an obstacle.
It uses the HS-SR04 ultrasonic sensor connected to the Nexys A7 FPGA board to measure the distance between the vehicle and the obstacle.
Ultrasonic sensors send trigger signals and after receiving the echo signal measure a time that is directly proportional to the distance from the obstacle.
The measured distance is shown on the seven-segment display, which allows the user to easily judge how far the vehicle is from the obstacle.
## Hardware description of demo application
### Nexys A7-50T
Nexys A7-50T board is a complete, ready-to-use digital circuit development platform based on the latest Artix-7™ Field Programmable Gate Array (FPGA) from Xilinx®. With its large, high-capacity FPGA, generous external memories, and collection of USB, Ethernet, and other ports, the Nexys A7 can host designs ranging from introductory combinational circuits to powerful embedded processors. Several built-in peripherals, including an accelerometer, temperature sensor, MEMs digital microphone, a speaker amplifier, and several I/O devices allow the Nexys A7 to be used for a wide range of designs without needing any other components.

<img width="666" alt="Snímek obrazovky 2024-04-23 v 12 55 41" src="https://github.com/marakaja/UltrasonicEchoProject/assets/145433293/b487c991-0dbe-4736-b463-d91d7ae31129">


### Ultrasonic sensor HC-SR04
It is a sensor for distance measurement.The module will send out ultrasonic burst. These ultrasonic sound waves travels through the air and if it finds an object or obstacle on its path then it will automatically reflect or bounce back to the receiver of the module.

<img width="666" alt="Snímek obrazovky 2024-04-23 v 12 48 15" src="https://github.com/marakaja/UltrasonicEchoProject/assets/145433293/2109684e-d15a-41ef-ade5-9eba22c9fa38">

### Arduino uno
We used Arduino uno to supply the 5V power needed by the HC-SR04 ultrasonic sensor.
![Arduino_Uno_-_R3](https://github.com/marakaja/UltrasonicEchoProject/assets/145433293/34819ffb-b302-4bd0-ab2a-85b4acf81431)

## Software description
The software for this project in written in VHDL. Here are components that we used to make smart parking system. <br> <br>
`LEDcontrol.vhd` - This module controls the LEDs on the board based on the calculated distance from the obstacle. The distance is obtained from the input signal “inputNumber” and converted to LEDs according to predefined rules. <a href="https://github.com/marakaja/UltrasonicEchoProject/blob/main/UltrasonicEcho.srcs/sources_1/new/LEDcontrol.vhd">LEDcontrol.vhd</a> <br> 
`clock_enable.vhd` - generates a pulse signal based on the master clock signal to enable other components. <a href="https://github.com/marakaja/UltrasonicEchoProject/blob/main/UltrasonicEcho.srcs/sources_1/new/clock_enable.vhd">clock_enable.vhd</a> <br> 
`segment.vhd` - This module controls the seven-segment display based on the calculated distance to the obstacle. The distance is obtained using the input signal "inputNumber" and converted to a seven-segment display. <a href="https://github.com/marakaja/UltrasonicEchoProject/blob/main/UltrasonicEcho.srcs/sources_1/new/segment.vhd">segment.vhd</a> <br> 
`time_counter.vhd` - It implements a counter to measure the time between the trigger signal and the echo signal from the ultrasonic sensors. <a href="https://github.com/marakaja/UltrasonicEchoProject/blob/main/UltrasonicEcho.srcs/sources_1/new/time_counter.vhd">time_counter.vhd</a> <br>
`toplevel.vhd` - The main component connecting all parts and controlling the behavior of the system. <a href="https://github.com/marakaja/UltrasonicEchoProject/blob/main/UltrasonicEcho.srcs/sources_1/new/toplevel.vhd">toplevel.vhd</a> <br>

## Instructions
Instruction manual for your application, including photos and a link to a short app video.
## Video of working project
[![Our project](https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRQ9_bqw1eS4LBZrmvqx8KZyM2dENurni9gWR11YMBvZA&s)](https://www.youtube.com/watch?v=ZKmbBe2K_lw)
## References
