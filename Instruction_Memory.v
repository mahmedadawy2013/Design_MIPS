/******************************************************************************
* Module: Private - Instruction_Memory Block 
*
* File Name: Program Counter.v
*
* Description: The PC is simply connected to the address input of the instruction 
*              memory. The instruction memory reads out, or fetches, the 32-bit 
*              instruction, labeled Instr. Our instruction memory is a Read Only 
*              Memory (ROM) that holds the program that your CPU will execute. The
*              ROM Memory has width = 32 bits and depth = 100 entries. Instr is read asynchronously..
*
* Author: Mohamed A. Eladawy
*
*******************************************************************************/
//********************Port Declaration*************************//

module Instruction_Memory # (

parameter Program_Counter_Width   = 32 , //initialize a parameter variable with value 32 
parameter Instrucion_output_Width = 32 ) //initialize a parameter variable with value 32 

(

input wire  [Program_Counter_Width-1   :0] PC_Input ,         //Declaring the Variable As an Input Port with width 32 bits
output reg  [Instrucion_output_Width-1 :0] Instrucion_output  //Declaring the Variable As an Output Port with width 32 bits  

); 
//****************** Parameeters Initialization  ****************//

localparam         Zero           = 1'b0   ,            //initialize a parameter variable with a binary value 0
                   ONE            = 1'b1   ,            //initialize a parameter variable with a binary value 1
                   Memory_Width   = 32     ,            //initialize a parameter variable with a Decimal value 32                   
                   Memory_depth   = 100    ;            //initialize a parameter variable with a Decimal value 100                   
                   
//******************** Memory Initialization  *******************// 
 
reg [Memory_Width-1 : 0]  Instrucion_Memory [Memory_depth-1 :0]  ; //Create An Instrucion Memory With width 32 and Depth 100 

//********************Internal Signal Declaration*****************//

//reg Instrucion_Address  ; 

//*************************** The RTL Code *****************************//

initial begin $readmemh("Program 1_GCD_of_two_numbers.txt",Instrucion_Memory); //reading file that contains the program.

end

/***************** Starting Combinational Always Block *****************/

always @ (*) 

/*
*  Assume that our Memory is not word aligned. It supports unaligned data of 32 bits, 
*  so we need to divide our address by 4 (PC >> 2 = PC / 4).
*/
   begin 
     
   //Instrucion_Address = (  )                       ; 
   Instrucion_output  = Instrucion_Memory [PC_Input >> 2] ;  
     
   end              //end of the always Block 
                                
                  
/*********************************************************************/

endmodule