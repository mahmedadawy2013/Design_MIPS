/******************************************************************************
* Module: Private - Data Memory Block 
*
* File Name: Data_Memory.v
*
* Description: The data memory is a RAM that provides a store for the CPU to load
*              from and store to. The Data Memory has one output read port (RD) and
*              one input write port (WD). Reads are asynchronous while writes are synchronous
*              to the rising edge of the ?clk? signal. The Word width of the data memory is 32-bits
*              to match the datapath width. The data memory contains 100 entries.
*
* Author: Mohamed A. Eladawy
*
*******************************************************************************/
//********************Port Declaration*************************//

module Data_Memory #(

parameter Data_Width     = 32 , //initialize a parameter variable with value 32
parameter Test_Width     = 16 , //initialize a parameter variable with value 32  
parameter Address_Width  = 32  ) //initialize a parameter variable with value 5 

(

input wire [Address_Width-1  :0]  Address_Data_memory , //Declaring the Variable As an Input Port with width 5 bits
input wire [Data_Width-1     :0]  Write_Data_memory   , //Declaring the Variable As an Input Port with width 32 bits
input wire                        CLK                 , //Declaring the Variable As an Input Port with width 1 bit
input wire                        RST                 , //Declaring the Variable As an Input Port with width 1 bit
input wire                        Write_Enable_memory , //Declaring the Variable As an Input Port with width 1 bit
output reg [Test_Width-1  :0]     TEST_RESULT         , //Declaring the Variable As an Input Port with width 16 bit
output reg [Data_Width-1  :0]     Read_Data_memory      //Declaring the Variable As an Output Port with width 32 bits

);

//****************** Parameeters Initialization  ****************//

localparam         Zero           = 32'b0  ,            //initialize a parameter variable with a binary value 0
                   ONE            = 1'b1   ,            //initialize a parameter variable with a binary value 1
                   Memory_Width     = 32   ,            //initialize a parameter variable with a Decimal value 32                   
                   Memory_depth     = 100  ;            //initialize a parameter variable with a Decimal value 100 
                   
//******************** Memory Initialization  *******************// 
 
 reg [Memory_Width -1 : 0]  Data_Memory [Memory_depth-1 :0]  ; //Create An Instrucion Memory With width 32 and Depth 100 
 integer i;

//*************************** The RTL Code *****************************//
/***************** Starting The Sequential Always Block *****************/

always @ (posedge CLK or negedge RST ) 

 begin 
   
  if ( !RST )                                          // Check Data memory  active low asynchronous reset signal
    
    begin 
      
      
        for(i=0;i<100;i=i+1)
        begin 
         Data_Memory[i] = 32'd0   ;
        end 
    //    Data_Memory[Address_Data_memory] <=  Zero  ;   //Put a Zero inside the Data memory With Address A
    
    end 
    
  else if (Write_Enable_memory) 
    
    begin 
     
        Data_Memory[Address_Data_memory] <=  Write_Data_memory   ;   //Put a The Value of WD  inside the Memory With Address A 
      
    end
    
  else
    
    begin 
      
        Data_Memory[Address_Data_memory] <=  Zero  ;   //Put a Zero inside the Data memory With Address A
      
    end
    
end

/***************** Starting Combinational Always Block *****************/ 

always @ (*)

begin 
  
   Read_Data_memory = Data_Memory[Address_Data_memory]  ;    //Output the RD From the Memory With Address A 
    
end 

/***************** Starting Seconed Combinational Always Block *****************/ 

always @ (*)

begin 
  
   TEST_RESULT = Data_Memory[0]  ;    //Output the Test Value
    
end                  
endmodule                   
