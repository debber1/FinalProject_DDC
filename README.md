# Final project DDC

## Authors
* Alessia Fumagalli
* Robbe Decapmaker

## Extra features

The Pynq-Z2 board is not only capable of running verilog code on its FPGA, it also has a SOC which can run an operating system. For our extra features we chose to run a striped down version of Ubuntu 18.04 on this SOC. This enables us to run other programming languages such as C or C++ on the Pynq board. However, we chose to use python because it is an easy programming language with built in libraries for this application.

### How it works

When we want to boot the Ubuntu image, we first need to change the bootpin to indicate that we want to boot from the inserted SD card. When the OS has booted, it exposes a tty over USB and a website to run Jupyter notebooks. The latter is the method we use to controll the Pynq board, while the former is handy for debugging the boot process of the OS.

Using the libraries provided by Xilinx, we can controll a set of GPIO pins integrated we can interface with the FPGA. On the verilog side of things, life is made easy again because there is IP which handles the interface with the SOC. This gives us an IO bus which we can just treat as external inputs.

### What does it do

The exact functions are all present and documented in the `FinalProject.py` file located at the root of this project. But a basic overview looks as follows:
* Change text colours
* Change background colours
* Manipulate the FSM to display a desired hexadecimal number
* Manipulate the FSM to fill the screen with a countup
* Manipulate the FSM to fill the screen with a countdown
* Manipulate the FSM to fill the screen with a desired hexadecimal number
* Reset the system
