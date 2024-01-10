/******************************************************************************
* Module: Private - Program Counter Block 
*
* File Name: Program Counter.v
*
* Description: The program counter (PC) register contains the 32-bit address of
*              the instruction to execute. The program counter is a synchronous 
*              unit that is updated at the rising edge of the clock signal ?clk?.
*              The program counter is asynchronously cleared (zeroed) whenever the 
*              active low reset signal ?rst? is asserted.
*
* Author: Mohamed A. Eladawy
*
*******************************************************************************/
//********************Port Declaration*************************//

module program_Counter #(
  
parameter Address_width = 32 ) //initialize a parameter variable with value 32 

(
input wire                      CLK                    , //Declaring the Variable As an Input Port with width 1 bit
input wire                      RST                    , //Declaring the Variable As an Input Port with width 1 bit
input wire [Address_width-1 :0] Program_Counter_input  , //Declaring the Variable As an Input Port with width 32 bits
output reg [Address_width-1 :0] Program_Counter_output   //Declaring the Variable As an Output Port with width 32 bits  

); 
//****************** Parameeters Initialization  ****************//

localparam         Zero           = 32'b0   ;            //initialize a parameter variable with a binary value 0
                    

//*************************** The RTL Code *****************************//
/***************** Starting The Sequential Always Block *****************/

always @ (posedge CLK or negedge RST ) 

 begin 
   
  if ( !RST ) 
    
    begin 
     
       Program_Counter_output <=  Zero  ; 
    
    end 
    
  else
      
     begin 
     
       Program_Counter_output <= Program_Counter_input ; 
    
    end    
   
end              //end of the always Block

//**********************************************************************//
endmodule
