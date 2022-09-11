# BOOTH'S MULTIPLIER USING VERILOG
  Booth's multiplication algorithm is a multiplication algorithm that multiplies two signed binary numbers in two's complement notation. The algorithm was invented by Andrew Donald Booth in 1950 .In this project, we have designed and implemented the Booths Algorithm for Multiplication using the data path and the control path. The module desigmed is capable of performing multiplication of two 4-bit signed numbers which generates a 10-bit result.
# INDEX
- [Booth's Multiplier using Verilog](https://github.com/ddm2000/Booths_Multiplier/blob/main/README.md#booths-multiplier-using-verilog)
- [Index]()
- [Introduction]()
- [Booth's Algorithm]()
    - [Basic Idea]()
    - [Example]()
- [Flow Chart]()
- [Data Path]()
- [Control Path]()
- [State Diagram]()
- [Simulation Results]()
    - [CLI Output]()
    - [Graphical Output using GTKwave]()
    - [Xilinx iSim Output]()
- [Implementation]()
- [Conclusion]()
- [References]()
# Booth's Algorithm
  Booth's multiplication algorithm is a multiplication algorithm that multiplies two signed binary numbers in two's complement notation. In the conventional shift and add operation, for n-bit multiplication, we either add 0 or the multiplicand to the 2n-bit partial product, shift the partial product to the right, and repeat this entire process n times. However, while applying Booth's algorithm, we can avoid the additions whenever consecutive 0's or 1's are detected in the multiplier. Hence, this is a huge improvement from the conventional multiplication algorithm, and it makes the process a lot faster.
  
Basic Idea:

1. In Booth's algorithm, we inspect two bits of the multiplier (Q)

![Booths_Block_Diagram](https://user-images.githubusercontent.com/90913438/189526563-2c735189-becb-4497-92b6-2ee9173ceb7d.png)
![Booths_Flow_Chart](https://user-images.githubusercontent.com/89533085/189528949-fa907629-96c5-4b9a-a32f-4b5c267f45b0.png)
![Booths_Multiplier_Data_Path](https://user-images.githubusercontent.com/89533085/189529052-14875833-db44-4102-83c7-d45347c6b8c2.png)
![Booths_State_Diagram](https://user-images.githubusercontent.com/90913438/189526567-032fe8de-6611-4b8c-802c-920c27ee7aad.png)
