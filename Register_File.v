/******************************************************************************
* Module: Private - Register File Block 
*
* File Name: Register_File.v
*
* Description: The Register File contains the 32 32-bit MIPS registers. 
*              The register file has two read output ports (RD1 and RD2) 
*              and a single input write port (WD3). The register file is 
*              read asynchronously and written synchronously at the rising 
*              edge of the clock. The register file supports simultaneous read 
*              and writes. The register file has width = 32 bits and depth = 100 entries.
*
* Author: Mohamed A. Eladawy
*
*******************************************************************************/
//********************Port Declaration*************************//

module Register_File #(

parameter Register_Width = 32 , //initialize a parameter variable with value 32 
parameter Address_Width  = 5  ) //initialize a parameter variable with value 5 

(

input wire [Address_Width-1  :0]  A1              , //Declaring the Variable As an Input Port with width 5 bits
input wire [Address_Width-1  :0]  A2              , //Declaring the Variable As an Input Port with width 5 bits
input wire [Address_Width-1  :0]  A3              , //Declaring the Variable As an Input Port with width 5 bits
input wire [Register_Width-1 :0]  WD3             , //Declaring the Variable As an Input Port with width 32 bits
input wire                        CLK             , //Declaring the Variable As an Input Port with width 1 bit
input wire                        RST             , //Declaring the Variable As an Input Port with width 1 bit
input wire                        Register_Enable , //Declaring the Variable As an Input Port with width 1 bit
output reg [Register_Width-1  :0]  RD1            , //Declaring the Variable As an Output Port with width 32 bits
output reg [Register_Width-1  :0]  RD2              //Declaring the Variable As an Output Port with width 32 bits  

);

//****************** Parameeters Initialization  ****************//

localparam         Zero           = 32'b0  ,            //initialize a parameter variable with a binary value 0
                   ONE            = 1'b1   ,            //initialize a parameter variable with a binary value 1
                   File_Width     = 32     ,            //initialize a parameter variable with a Decimal value 32                   
                   File_depth     = 32     ;            //initialize a parameter variable with a Decimal value 100 
                   
//******************** Memory Initialization  *******************// 
 
 reg [File_Width -1 : 0]  Register_File [File_depth-1 :0]  ; //Create An Instrucion Memory With width 32 and Depth 100 
 integer i ; 

//*************************** The RTL Code *****************************//
/***************** Starting The Sequential Always Block *****************/

always @ (posedge CLK or negedge RST ) 

 begin 
   
  if ( !RST )                           // Check register file  active low asynchronous reset signal
    
    begin 
     
      for(i=0;i<32;i=i+1) 
      
      begin 
      
      Register_File[i] = 32'd0 ; //Put a Zero inside the register With Address A3
      
      end 
    
    end 
    
  else if (Register_Enable) 
    
    begin 
     
        Register_File[A3] <=  WD3   ;   //Put a The Value of WD3 inside the register With Address A3 
      
    end
    
  else
    
    begin 
      
        Register_File[A3] <=  Zero  ;   //Put a Zero inside the register With Address A3  
      
    end
    
end

/***************** Starting Combinational Always Block *****************/ 

always @ (*)

begin 
  
   RD1 = Register_File[A1]  ;    //Output the RD1 Fro the Rgister File With Address A1 
   RD2 = Register_File[A2]  ;    //Output the RD2 Fro the Rgister File With Address A2 
    
end 
                 
endmodule                   