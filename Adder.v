/******************************************************************************
* Module: Private - Adder Block 
*
* File Name: Adder.v
*
* Description: This is a simple combination block. It is an adder block that adds
*              two 32-bit data inputs to each other (A and B) and produces the 
*              output to the 32-bit port C.
*
* Author: Mohamed A. Eladawy
*
*******************************************************************************/
//********************Port Declaration*************************//

module Adder  #(

parameter Data_Size_A = 32 ,                                //initialize a parameter variable with value 32 
parameter Data_Size_B = 32 ,                                //initialize a parameter variable with value 32 
parameter Data_Size_C = 32 )                                //initialize a parameter variable with value 32 

(
  
input wire [Data_Size_A-1 :0]              INPUT_A  , //Declaring the Variable As an Input Port
input wire [Data_Size_B-1 :0]              INPUT_B  , //Declaring the Variable As an Input Port
output reg [Data_Size_C-1 :0]              OUTPUT_C   //Declaring the Variable As an Output Port
  
);

                   
//*************************** The RTL Code *****************************//
//**************** Starting Combinational Always Block *****************//

always @ (*)

begin 

 OUTPUT_C = ( INPUT_A + INPUT_A ) ; // Adding The 2 Inputs And The Sum Is the Output
 
end 

//**********************************************************************//

endmodule    
