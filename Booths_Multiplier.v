//Problem Statement : Write a Verilog module to multiply Two 4 bit signed numbers using Booth's algorithm 
//			i.   A, M and Q Three 5 bit shift Registers to be used 
//			ii.  M is multiplier and Q is Multiplicand 
//			iii. A will be temporary register. 
//			iv. The final Result will be stored in both A and Q 
// 			v.  The design should be implemented using a data path and a control path.   
//==============================================================================================
// File Name : Booths_Multiplier.v 
// Type 	: MVM + TVM 
// Author 	: Debayan Mazumdar                   | Nishad P Potdar 
// Mail 	: debayanmazumdar0@gmail.com | nishadppotdar09@gmail.com 
//==============================================================================================
// Release History 
// Version 1.0 	11/09/2022	
// ==============================================================================================
// Keywords : Booth's Multiplier, Signed 4-bit Numbers 
// ==============================================================================================
// MVM : 

//Shift Register 
module shift_reg (dout, din, sin, ld, shift, clr, clk);  
	//Port Section 
	input [4:0] din ;
	input sin, ld, shift, clk, clr ;
	output reg [4:0] dout ; 
	
	always @ (posedge clk)
		if (clr)
			dout <= 5'b0 ;
		else if(ld)   					// If Load signal is high the data from the bus will be loaded. 
			dout <= din ;
		else if (shift)					// If Shift signal is high then bits will be shifted serially. 
			dout <= {sin, dout[4:1]} ;
endmodule 

//PIPO Shift Register 
module PIPO (pout, pin, ldP, clk) ; 
	//Port Section 
	input [4:0] pin ;
	input ldP, clk ;
	output reg [4:0] pout ; 
		
	always @ (posedge clk)	
		if(ldP)						// If Load signal is high the data from the bus will be loaded. 
			pout <= pin ; 
endmodule 

//D Flip Flop 
module d_ff (q, d, clrd, clk); 				// D FF is used to store the Qm1 bit. 
	//Port Section
	input d, clrd, clk ; 
	output reg q ;
		
	always @ (posedge clk)
		if (clrd)					// If Clr is high FF will be cleared else the value of D will be loaded. 
			q <= 0 ;
		else 
			q <= d ;
endmodule 

//ALU     
module ALU (out, a, b, sel) ;				// The ALU is assigned the operation of addition or subtraction depending on the sel. 
	//Port Section 
	input [4:0] a, b ;
	input sel ;
	output reg [4:0] out; 
	
	always @ (*)
		if (sel)
			out = a + b ;
		else
			out = a - b ; 
endmodule 

//Counter 
module CNTR (cout, ldC, decC, clk); 			// This down counter is used to count the number of cycles to be executed.  
	//Port Section 
	input decC, clk, ldC ; 
	output reg [2:0] cout ;

	always @(posedge clk)
		if (ldC ==1'b1)
			cout <= 3'b101 ; 			//The inital value loaded in counter will be same as that of the number of bits (here 5 bit).
		else if (decC)
			cout <= cout - 1 ;
endmodule 

//Data Path 
module booth_data_path (iszero, qm1, q0, decr, ldcount, shiftA, ldA, clrA, ldM, ldQ, clrQ, shiftQ, clrff, data_in, addsub, clk) ;
	//Port Section 
	input  decr, ldcount, shiftA, ldA, clrA, ldM, ldQ, clrQ, shiftQ, clrff, addsub, clk ; 
	input [4:0] data_in ;
	output iszero, qm1, q0 ;
	wire  [4:0] A, M, Q, Z ;
	wire  [2:0] count ;
	
	assign iszero = ~| count ;  				// The iszero will be set once the count reaches to zero (3'b000)
	assign q0 = Q[0] ; 					// The LSB of Register QSR will be loaded into q0 which will act as input to flip flop. 
	
	// Module Instantiation 
	shift_reg QSR   (Q, data_in, A[0], ldQ, shiftQ, clrQ, clk) ;   // Reg Q
	shift_reg ASR   (A, Z, A[4], ldA, shiftA, clrA, clk) ;		// Reg A	
	PIPO     MPR   (M, data_in, ldM, clk) ; 			//Reg M 
	d_ff     QM  (qm1, q0, clrff, clk) ;				//D Flip Flop (for qm1)
	ALU   ALU (Z, A, M, addsub) ;					//ALU
	CNTR CNT (count, ldcount, decr, clk) ;			//Counter 
endmodule 

//Control Path 
module booth_control_path (iszero, qm1,q0, decr, ldcount, shiftA, ldA, clrA, ldM, ldQ, clrQ, shiftQ, clrff, data_in, addsub, clk, start, done) ;
	//Port Section
	output reg decr, ldcount, shiftA, ldA, clrA, ldM, ldQ, clrQ, shiftQ, clrff, addsub, done ;  
	input start, iszero, qm1, q0, clk ; 
	input[4:0] data_in  ;
	reg[2:0] state ;
	
	//States
	parameter 	S0 = 3'b000 , 
			S1 = 3'b001 , 
			S2 = 3'b010 ,
			S3 = 3'b011 ,
			S4 = 3'b100 ,
			S5 = 3'b101 ,
			S6 = 3'b110 ;

	always@ (posedge clk) 
	
	//Implementation of State Diagram of control path 
	case (state)
		S0 	: 	if (start) state <= S1 ;
		S1 	: 	state <= S2 ;
		S2 	: 	#2 if ({q0, qm1} == 2'b01) state <= S3 ; 
				else if ({q0, qm1} == 2'b10) state <= S4 ;
				else state <= S5 ; 
		S3 	: 	state <= S5 ;
		S4 	: 	state <= S5 ;
		S5 	: 	#2 if (({q0, qm1} == 2'b01) && (!iszero))
					state <= S3 ;
				else if (({q0, qm1} == 2'b10) && (!iszero))
					state <= S4 ;
				else if (iszero)
					state <= S6 ;
		S6 	: 	state <= S6 ; 
	   	default:	state <= S0 ; 
	endcase 
			
	always @(state)
	
	//Assigning the control signals of the data path as per the state. 
	case (state)
		S0 	:  begin 								
				decr = 0 ;  ldcount = 0 ; shiftA = 0 ; ldA = 0 ; clrA = 0 ; ldM = 0 ;
 				ldQ =  0 ;  clrQ = 0 ;  shiftQ = 0 ; clrff  = 0 ; addsub = 0 ; done = 0;
			end 
		S1 	:  begin 
				clrA = 1 ; clrff = 1 ; ldcount = 1 ; ldM = 1 ;
			end 
		S2 	:  begin 
				clrA = 0 ; ldcount = 0 ; ldM = 0 ; ldQ = 1 ; decr = 0 ; 
              end 
		S3 	: begin 
				shiftA = 0 ; shiftQ = 0 ;ldQ = 0 ; addsub = 1 ; ldA = 1 ; decr = 0 ;
			end 
		S4 	: begin 
				shiftA = 0 ; shiftQ = 0 ;ldQ = 0 ; addsub = 0 ; ldA = 1 ; decr = 0 ;
			end 
		S5 	: begin
				clrff = 0; ldQ = 0 ; ldA = 0 ; shiftA = 1 ; shiftQ = 1 ; decr = 1 ;
			end 		 
		S6 	:   begin 
				shiftA = 0 ; shiftQ = 0 ; decr = 0 ; done = 1 ;
			end  
		default : begin 
				decr = 0 ;  ldcount = 0 ; shiftA = 0 ; ldA = 0 ; clrA = 0 ; ldM = 0 ;
 				ldQ =  0 ;  clrQ = 0 ;  shiftQ = 0 ; clrff  = 0 ; addsub = 0 ; done = 0;
			end  
	endcase 
endmodule 

// ==============================================================================================
// TVM : 

module Booths_Multiplier_tb ;
	//Port Section 
	reg clk ; 
	reg start ; 
	reg [4:0] data_in ;
	wire done ; 
	wire[1:0] temp;
	
	//Module Instantiation 
	booth_data_path	BOOTH_DP (iszero, qm1, q0, decr, ldcount, shiftA, ldA, clrA, ldM, ldQ, clrQ, shiftQ, clrff, data_in, addsub, clk) ;
	booth_control_path  BOOTH_CP (iszero, qm1, q0, decr, ldcount, shiftA, ldA, clrA, ldM, ldQ, clrQ, shiftQ, clrff, data_in, addsub, clk, start, done) ;

	initial 
		begin
			clk  = 1'b0 ;
			start = 1'b1;
		end 
	always 
		#5 clk = ~ clk ; 		// Clk of Time period 10 Time units. 
	initial 
		begin
			data_in = 7; 		// Value of M 
			#27 data_in = 8 ; 	// Value of Q 
		end 
		
	initial 
		begin 
			$dumpfile ("Booths.vcd") ; 
			$dumpvars (0, Booths_Multiplier_tb) ; 
			$display ("                                                   Booths Multiplier for Signed 4 Bit Numbers") ;
			$display ("                                                 Developed By : Debayan Mazumdar | Nishad Potdar") ;
			$monitor ($time , " | M: %5b | A: %5b |  Q: %5b | Q[-1]: %b | COUNT: %3b | ISZERO: %b | STATE: %3b | DONE: %b |",
					BOOTH_DP.M, BOOTH_DP.A, BOOTH_DP.Q, BOOTH_CP.qm1, BOOTH_DP.count, BOOTH_DP.iszero, BOOTH_CP.state, done) ; 
			#1000 $finish ;
		end
endmodule

// ==============================================================================================
