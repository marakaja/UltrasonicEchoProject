# Smart Parking System with Ultrasonic Sensors
* [Theoretical description and explanation](#theoretical-description-and-explanation)
* [Hardware description of demo application](#hardware-description-of-demo-application)
* [Software description](#software-description)
* [Components simulation](#components-simulation)
* [Instructions](#instructions)
* [References](#references)
  

### Team members
Member 1: Marek Karlíček <br/>
Member 2: Tomáš Kučera <br/>
Member 3: Jan Kříž <br/>
Member 4: Rauf Iusupov <br/>
## Theoretical description and explanation
Description of the problem and how to solve it. 
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
The software for this project in written in VHDL. Here are components that we used to make smart parking system. <br>
`LEDcontrol.vhd` - <br>
`clock_enable.vhd` - <br>
`segment.vhd` - <br>
`time_counter.vhd` - <br>
`toplevel.vhd` - <br>

## Components simulation
Write descriptive text and put simulation screenshots of your components.
## Instructions
Instruction manual for your application, including photos and a link to a short app video.
## References
