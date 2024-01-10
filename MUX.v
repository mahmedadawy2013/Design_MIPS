/******************************************************************************
* Module: Private - MUX Block 
*
* File Name: Adder.v
*
* Description: implement a parameterized 2X1 MUX.
*
* Author: Mohamed A. Eladawy
*
*******************************************************************************/
//********************Port Declaration*************************//

module MUX  #(

parameter Data_Size_A = 32 ,                                //initialize a parameter variable with value 32 
parameter Data_Size_B = 32 ,                                //initialize a parameter variable with value 32 
parameter Data_Size_C = 32 )                                //initialize a parameter variable with value 32 

(
  
input wire [Data_Size_A-1 :0]              INPUT_A  , //Declaring the Variable As an Input Port with Width 32 bits
input wire [Data_Size_B-1 :0]              INPUT_B  , //Declaring the Variable As an Input Port with Width 32 bits
input wire                                 SEL      , //Declaring the Variable As an Input Port with Width 1 bit
output reg [Data_Size_C-1 :0]              OUTPUT_C   //Declaring the Variable As an Output Port with Width 32 bits
  
);

                   
//*************************** The RTL Code *****************************//
//**************** Starting Combinational Always Block *****************//

always @ (*)

begin 

 if (SEL)                     //Check If the Selction Line Is equal to one or zero to decide the output
   
   begin 
     
      OUTPUT_C = INPUT_B  ;   //The Output Is equal to the Seconed Input   
     
   end 
   
else
  
  begin 
    
    OUTPUT_C = INPUT_A  ;   //The Output Is equal to the First Input   
    
  end 
 
end 

//**********************************************************************//

endmodule    

