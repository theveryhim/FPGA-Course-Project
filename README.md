This is a simple signal processing project on Zynq which includes:
  - Introduction to Scrambler and Descrambler
  - Introduction to FFT and displaying the spectrum of digital signals via HDMI on the display

![Overview of project](https://github.com/user-attachments/assets/e7c73c87-2a06-4fa6-85f6-3a38b8a34664)
## Stage 1:
In this phase, you initially create four types of square, sawtooth, triangular, and sine waves 
in PS (each with 1024 samples, 8-bit). You transfer this signal to PL through the HP port with 
the appropriate configuration for DMA. By pressing 1KEY_PS, the sent signal to the FPGA changes 
between the four created signals.

Related Documents:
  - [Vivado project file](https://www.dropbox.com/scl/fo/mbf7uec3n0lks7kfpmr7v/AB-lu52Xzw_MyFjoZeSUaDY?rlkey=t8ngle1a1tjvpvgnyj29x9w6w&st=9xh5f244&dl=0)
  - Report01
## Stage 2:
In this satge, a conventional ASM structure is added along with a Scrambler. In fact, ultimately 
in this project, you will implement a transmitter in the PS section and a receiver in the PL section.
We use the DS/CCS header or send multiple samples as a header and wait to receive it at the receiver
to reset our Descrambler.

*July 2024* 
