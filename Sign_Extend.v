/******************************************************************************
* Module: Private - Sign Extend Block 
*
* File Name: Sign_Extend.v
*
* Description: Sign extension simply copies the sign bit (most significant bit)
*              of a short input (16 bits) into all of the upper bits of the longer output (32 bits).
*              Inst[15:0] = 0000 0000 0011 1101 ---->
*                   SignImm = 0000 0000 0000 0000 0000 0000 0011 1101
*              Inst[15:0] = 1000 0000 0011 1101 ---->
*                   SignImm = 1111 1111 1111 1111 1000 0000 0011 1101 
*
* Author: Mohamed A. Eladawy
*
*******************************************************************************/
//********************Port Declaration*************************//

module Sign_Extend #(
  
parameter Instruction_Size = 16          , //initialize a parameter variable with value 16
parameter Instruction_Size_Extended = 32 ) //initialize a parameter variable with value 32

(

input wire [Instruction_Size-1        :0] Instruction_Input   , //Declaring the Variable As an Input Port with width 16 bits
output reg [Instruction_Size_Extended-1 :0] Instruction_Extended  //Declaring the Variable As an Output Port with width 32 bits 

);

//****************** Parameeters Initialization  ****************//

localparam         Most_significant_Bit = 15                 ,            //initialize a parameter variable with a binary value 15  
                   ZERO            = 1'b0                    ,            //initialize a parameter variable with a binary value 0
                   ONE             = 1'b1                    ,            //initialize a parameter variable with a binary value 1
                   ZEROS           = 16'b0000_0000_0000_0000 ,            //initialize a parameter variable with a binary value of 16 zero
                   ONES            = 16'b1111_1111_1111_1111 ;            //initialize a parameter variable with a binary value of 16 one
                   
//*************************** The RTL Code *****************************//
//**************** Starting Combinational Always Block *****************//                   
                   
always @ (*)

begin 

if ( Instruction_Input[Most_significant_Bit] == ZERO )                //Check if the Most significant Bit equal to zero 
  
   begin 
     
     Instruction_Extended = {ZEROS , Instruction_Input } ;            //Extend the instruction with Zeroes 
     
   end 

else 
  
   begin 
     
     Instruction_Extended = {ONES , Instruction_Input } ;            //Extend the instruction with Ones 
     
   end 

end 

//*******************************************************************************//

endmodule                                     
                   
                   
                   
                   
                   