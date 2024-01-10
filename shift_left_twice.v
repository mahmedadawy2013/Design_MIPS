/******************************************************************************
* Module: Private - shift left twice Block 
*
* File Name: shift_left_twice.v
*
* Description: This block only shift the input to the left twice. 
*              this block parameterized, as you need two versions
*              of it in your top module with two different data input width.
*
* Author: Mohamed A. Eladawy
*
*******************************************************************************/
//********************Port Declaration*************************//

module shift_left_twice  #(

parameter Data_Size = 32 )                                //initialize a parameter variable with value 32 

(
  
input wire [Data_Size-1 :0]              INPUT_SHIFTED  , //Declaring the Variable As an Input Port
output reg [Data_Size-1 :0]              OUTPUT_SHIFTED   //Declaring the Variable As an Output Port
  
);

//****************** Parameeters Initialization  ****************//

localparam         SHIFTER = 2                ;            //initialize a parameter variable with a binary value 2  
                   
//*************************** The RTL Code *****************************//
//**************** Starting Combinational Always Block *****************//

always @ (*)

begin 

 OUTPUT_SHIFTED = ( INPUT_SHIFTED << SHIFTER ) ; 
 
end 

//**********************************************************************//

endmodule    