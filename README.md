
# BOOTH'S MULTIPLIER USING VERILOG
<p align="center">
  <img src="https://evision-systems.de/wp-content/uploads/2021/06/evision-header-eda-chip09-full.jpg" />
</p>

<p align="center"> <a href="https://evision-systems.de/wp-content/uploads/2021/06/evision-header-eda-chip09-full.jpg">Image Coutersy</a> </p>

  Booth's multiplication algorithm is a multiplication algorithm that multiplies two signed binary numbers in two's complement notation. The algorithm was invented by Andrew Donald Booth in 1950. In this project, we have designed and implemented the Booths Algorithm for Multiplication using the data path and the control path. The module designed is capable of performing multiplication of two 4-bit signed numbers which generates a 10-bit result.
  
# INDEX
- [Booth's Algorithm](https://github.com/ddm2000/Booths_Multiplier/blob/main/README.md#booths-algorithm)
    - [Basic Idea](https://github.com/ddm2000/Booths_Multiplier/blob/main/README.md#basic-idea)
    - [Example](https://github.com/ddm2000/Booths_Multiplier/blob/main/README.md#example)
- [Tools Used](https://github.com/ddm2000/Booths_Multiplier/blob/main/README.md#tools-used)
- [Flow Chart](https://github.com/ddm2000/Booths_Multiplier/blob/main/README.md#flow-chart)
- [Data Path](https://github.com/ddm2000/Booths_Multiplier/blob/main/README.md#data-path)
- [Control Path and State Diagram](https://github.com/ddm2000/Booths_Multiplier/blob/main/README.md#control-path-and-state-diagram)
- [Block Diagram](https://github.com/ddm2000/Booths_Multiplier/blob/main/README.md#block-diagram)
- [Simulation Results](https://github.com/ddm2000/Booths_Multiplier/blob/main/README.md#simulation-results)
    - [CLI Output](https://github.com/ddm2000/Booths_Multiplier/blob/main/README.md#command-line-output)
    - [Graphical Output using GTKwave](https://github.com/ddm2000/Booths_Multiplier/blob/main/README.md#gtkwave-output)
    - [Xilinx iSim Output](https://github.com/ddm2000/Booths_Multiplier/blob/main/README.md#xilinx-ise-isim-output)
- [Implementation](https://github.com/ddm2000/Booths_Multiplier/blob/main/README.md#implentation)
- [Conclusion](https://github.com/ddm2000/Booths_Multiplier/blob/main/README.md#conclusion)
- [References](https://github.com/ddm2000/Booths_Multiplier/blob/main/README.md#references)
# BOOTH'S ALGORITHM
  Booth's multiplication algorithm is a multiplication algorithm that multiplies two signed binary numbers in two's complement notation. In the conventional shift and add operation, for n-bit multiplication, we either add 0 or the multiplicand to the 2n-bit partial product, shift the partial product to the right, and repeat this entire process n times. However, while applying Booth's algorithm, we can avoid the additions whenever consecutive 0's or 1's are detected in the multiplier. Hence, this is a huge improvement from the conventional multiplication algorithm, and it makes the process a lot faster. 
## Basic Idea:
1. In Booth's algorithm, we inspect two bits of the multiplier (Q<sub>i</sub> and Q<sub>i-1</sub>) at a time
   * If the bits are same (00 or 11), we only shift the partial product.
   * If the bits are 01, we do an addition and then shift.
   * If the bits are 10, we do a subtraction and then shift.
2. Initially, Q<sub>i-1</sub> is assumed to be zero.
## Example:
  Let us consider an example where we multiply two binary numbers using Booth's algorithm. We will multiply 7 and 8, and we will get 56 as the answer. Let M be the multiplier register, and Q be the multiplicand register. Also, let A be the temporary register used to calculate the product. Thus, in binary, we can write,
  
  >M = 00111, Q = 01000
  
  As initial value of A is 0,
  
  >A = 00000
  
  And finally, initial value of Q(-1) will be 0
  
  >Q(-1) = 0
  
  Now, the Booth's algorithm will multiply the two numbers as follows:
  
  ### Initially:
               
  >A = 00000, Q = 01000, Q(-1) = 0
                  
  As number of bits is 5, the multiplication will be carried out in 5 steps.
                  
  ### Step 1:
             
  As Q(0) = 0, Q(-1) = 0, the bits will be shifted as follows:
               
  A(MSB) -> A(MSB-1:0) -> Q -> Q(-1)
               
  >A = 00000, Q: 00100, Q(-1) = 0
               
  ### Step 2:
  
  As Q(0) = 0, Q(-1) = 0, the bits will be shifted again:
              
  >A = 00000, Q = 00010, Q(-1) = 0
               
  ### Step 3:
  
  As Q(0) = 0, Q(-1) = 0, the bits will be shifted again:
               
  >A = 00000, Q = 00001, Q(-1) = 0
                  
  ### Step 4:
               
  As Q(0) = 1, Q(-1) = 0, M(00111) will be subtracted from A(00000), and the result will be stored in A:
               
  >A = 11001, Q = 00001, Q(-1) = 1
                  
  After this, the bits will be shifted again:
               
  >A = 11100, Q = 10000, Q(-1) = 1             
  
  ### Step 5:
  
  As Q(0) = 0, Q(-1) = 1, M(00111) will be added to A(11100), and the result will be stored in A:
                
  >A = 00011, Q = 10000, Q(-1) = 0
                  
  After this, the bits will be shifted again:
                
  >A = 00001, Q = 11000, Q(-1) = 0
                
  Hence, the final result is {A,Q} = (0000111000)<sub>2</sub> = (56)<sub>10</sub>

# TOOLS USED 
- [Icarus verilog](http://iverilog.icarus.com/)
- [GTKWave](http://gtkwave.sourceforge.net/)
- [Xilinx ISE](https://www.xilinx.com/products/design-tools/ise-design-suite.html)
- [Draw.io](https://www.draw.io/)
- [Plan Ahead](https://www.xilinx.com/support/documentation-navigation/development-tools/mature-products/planahead.html)
- [Xilinx Spartan 3E](https://datasheet.lcsc.com/lcsc/2203231830_XILINX-XC3S500E-4PQG208C_C2976019.pdf)
# FLOW CHART 
<p align="center">
  <img src="https://user-images.githubusercontent.com/90913438/189547631-cf45fba9-1474-4494-b2f5-63d6e4a41d9f.png" />
 </p>
 <p align="center"> <b> Fig. 1 : Flow Chart </b> </p>



Following are the steps followed in the flow chart:

- Step 1: Start
- Step 2: 
    - Initialize register A and flip-flop Q(-1) to zero by clearing its contents.
    - Initialize the counter with 'n'(number of bits).
    - Initialize register M with the multiplicand.
    - Initialize register Q with the multiplier.
- Step 3: Check {Q(0),Q(-1)}
    - If {Q(0),Q(-1)} = "00" or "11, then go directly to step 4.
    - If {Q(0),Q(-1)} = "01", then add M to A, store in A, and go to step 4.
    - If {Q(0),Q(-1)} = "10", then subtract M from A, store in A, and go to step 4.
- Step 4:
    - Do an arithmetic shift operation on {A,Q,Q(-1)}.
    - Decrement counter.
- Step 5: Check counter
    - If counter!=0, go to step 3.
    - If counter=0, go to step 6.
- Step 6: Stop

# DATA PATH

<p align="center">
  <img src="https://user-images.githubusercontent.com/89533085/189529052-14875833-db44-4102-83c7-d45347c6b8c2.png" />
</p>
<p align="center"> <b> Fig. 2 : Data Path </b> </p>


  
  The above fig shown depicts the data path of the booth's multiplier. 
- It contains 3 Shift registers to store Multiplicand (M), Multiplier (Q) and the partial product (A). There is a common data_in line to load the values to M and Q. The values are loaded using control signals ldM and ldQ respectively. Along with ldQ, shift register Q is provided with few more control signals such as clrQ and shiftQ which are used to clear the register and shift the contents of register respectivly. The shift register A is initialized with 0. The shift register A is also provided with same control signals as that if register Q that are ldA to load value to A, clrA to clear the register and shiftA to shift the content. 
- There is one D type flip flop present which stores the value of LSB of Q register. The input to the flipflop is Q[0] and the output is qm1. But while computing the output of flipflop is assumed as Q[-1]. There is a control signla present to clear the flip flop.
- As we saw previosly, the booth's algorithm checks the bits Q[0]Q[-1] and decides whether to add partial product to multiplicand and then shift (case : 01) or to sub multiplicand from partial product and then shift (case : 10) or only shift the contents (case : 00/11). In first two cases i.e. when Q[0]Q[-1] are either 01 or 10, addition or subtraction operation needs to be performed. Thus an ALU i.e. an Arithmetic Logic Unit is present which carries out the addition and subtraction operation depending upon the select input applied. The select input is the control signal to the ALU which comes from the control path and is based on the value of Q[0]Q[-1]. The result of ALU is loaded back to A. The number of shifting operations is same as that of the number of bits which are loaded in the shift registers (both registers should be loaded with equal number of bits.) Here we have loaded 4-bit signed numbers thus the shifting operation needs to be performed 5 times. There is a down counter present to serve this purpose. It has control signal 'ldcount' which loads value 101 to counter and another control signal named 'decr' to decrement it to zero.
- While reading the output of booth's multiplier we read from the MSB of register of partial procut i.e. A to LSB of Multiplier i.e. Q[0] and leave Q[-1]. 
   
# CONTROL PATH AND STATE DIAGRAM

 <p align="center">
  <img src="https://user-images.githubusercontent.com/90913438/189547608-cdae9063-aa2d-4955-991c-c661bc2efb0f.png" />
</p>
<p align="center"> <b> Fig. 3 : Control Path </b> </p>
 

The above fig depicts the control path of the Booths multiplier. 
&nbsp&nbsp The control path is a controller which provides different control signals to the different data path modules. There are some feedback signals which originate from data path and are fed to control path. These signals are necessary for state trasition. The control path module is a Finite State Machine. There are some finite states and depending in which state currently the module is, the control signals are activated. The above diagram shows the states assigned to the block. 
- S0 : The module starts 
- S1 : When module is in state S1, the partial product shift register A gets loaded with all zeros. The count gets loaded to the counter and the Multiplicand M gets loaded through the data_in. 
- S2 : In state S2, the Multiplier value gets loaded. 
- S3 : If the Q(0)Q(-1) bits are 01 then module goes into state S3 where the value of multiplicand M and partial product A are loaded into ALU and are added with each other(A = A+M). The result again is stored into the register A. 
- S4 : If the Q(0)Q(-1) bits are 10 then module goes into state S4 where the value of multiplicand M and partial product A are loaded into ALU and are subtracted (A = A-M). The result again is stored into the register A. 
- S5 : The module changes its state from S2->S5 or from S3->S5 or from S4->S5 depending upon the the values of Q(0)Q(-1). The bits of A and Q gets shifted in this state except the MSB of A. 
- S6 : Module stops if counter reaches to zero. 
Depending upon the state and the feedback from data path, different control signals are set or reset. 

# BLOCK DIAGRAM

<p align="center">
  <img src="https://user-images.githubusercontent.com/90913438/189526563-2c735189-becb-4497-92b6-2ee9173ceb7d.png" />
</p>
<p align="center"> <b> Fig. 4 : Block Diagram </b> </p>
The above figure depicts the block diagram of the booth's multiplier. This shows the flow of signals in between control path and data path. Control path provides input to the data path. Following are the signals in the block diagram:

Control path to data path:

- ldA     : To load the partial product register. 
- clrA    : To clear the partial product register.
- shiftA  : To shift the data in partial product register. 
- ldQ     : To load the multiplier into the register. 
- shiftQ  : To shift the data in shift register Q. 
- ldM     : To load the multiplicand. 
- clrff   : To clear the flip flop. 
- addsub  : This acts as the select line of the ALU. 
- ldCount : To load the count value into the counter.
- decr    : To decrement the counter. 

Data path to control path:

- iszero  : To check whether counter has reached to zero or not.
- q0, qm1 : Q(0) and Q(-1) are the bits which decide the ALU operations.

Signals exclusive to control path:

- start   : This bit is set to start the multiplication.
- done    : This bit is set when the multiplication is finished.
# SIMULATION RESULTS 

Here the results are shown for the following test case.
M = 0111 (7)
Q = 1000 (8)
The expected answer is 111000 i.e. 56 

## Command Line Output
![image](https://user-images.githubusercontent.com/89533085/189895768-4fa4daf3-6610-416d-9812-5fb2f7994012.png)

<p align="center"> <b> Fig. 5 : Command Line Output </b> </p>

## GTKWave Output 

![image](https://user-images.githubusercontent.com/89533085/190196482-d625e3da-0bd2-4c05-87b9-4e4905bd411f.png)

<p align="center"> <b> Fig. 6 : GTKWave Graphical Output </b> </p>

## Xilinx ISE iSim Output 

# IMPLEMENTATION

# CONCLUSION

In this project, we have successfully designed the Booth's Multiplier using Data path and control path design. It is found that the multiplication done using booth's algorithm is much faster than the conventional add and shift algorithm. The design is simulated using two different softwares i.e. Icarus Verilog and Xilinx ISE iSim. 
After successfull simulation, the design is synthesized on FPGA and results are verified. 

# REFERENCES 
- [Prof. Indranil Sengupta, "Hardware Modelling Using Verilog", NPTEL](https://onlinecourses.nptel.ac.in/noc22_cs94/course)
 
