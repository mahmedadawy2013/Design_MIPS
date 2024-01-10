/******************************************************************************
*
* Module: Private - Arithmatic Logic Unit ' ALU ' Block 
*
* File Name: ALU.v
*
* Description:  An Arithmetic/Logical Unit (ALU) combines a variety of mathematical
*               and logical operations into a single unit. For example, a typical ALU
*               might perform addition, subtraction, magnitude comparison, AND, and OR 
*               operations. The ALU forms the heart of most computer systems. The 3-bit 
*               ALUControl signal specifies the operation. The ALU generates a 32-bit ALU
*               Result and a Zero flag, that indicates whether ALUResult == 0. The following
*               table lists the specified functions that our ALU can perform.
*
* Author: Mohamed A. Eladawy
*
*******************************************************************************/

//********************Port Declaration*************************//
module  ALU # (

parameter input_width   = 32 , //initialize a parameter variable with value 16 
parameter output_width  = 32 , //initialize a parameter variable with value 32 
parameter Control_width = 3  ) //initialize a parameter variable with value 3  
  
(
  
input wire [input_width-1 : 0 ]  SrcA       ,  //Declaring the Variable As an Input Port with width 16 bits 
input wire [input_width-1 : 0 ]  SrcB       ,  //Declaring the Variable As an Input Port with width 16 bits
input wire [Control_width-1 :0]  ALUControl ,  //Declaring the Variable As an Input Port with width 3 bits
output reg [output_width-1  :0]  ALUResult  ,  //Declaring the Variable As an Input Port with width 32 bits
output reg                       ZERO          //Declaring the Variable As an Input Port with width 1 bit                
  
);

//****************** Parameeters Initialization  ****************//

localparam          AND           = 3'b000 , //initialize a parameter variable with a binary value 000
                    OR            = 3'b001 , //initialize a parameter variable with a binary value 001                    
                    ADDITION      = 3'b010 , //initialize a parameter variable with a binary value 010 
                    NOT_USED      = 3'b011 , //initialize a parameter variable with a binary value 011
                    Subtraction   = 3'b100 , //initialize a parameter variable with a binary value 100
                    Multblication = 3'b101 , //initialize a parameter variable with a binary value 101
                    SLT           = 3'b110 , //initialize a parameter variable with a binary value 110
                    NOT_USED_Again = 3'b111 ,//initialize a parameter variable with a binary value 111 
                    ONE            = 1'b1   ,//initialize a parameter variable with a binary value 1
                    Zero           = 1'b0   ;//initialize a parameter variable with a binary value 0
                    
//*************************** The RTL Code *****************************//
/*************** Starting The Combinational Always Block ***************/

always @ (*)

begin                              //beigning of the Combinational Always Block  

case ( ALUControl )                //Case Statment on the ALUContol Input 

//*************************** Case 000 *****************************//
AND :
      begin                        //begining of the And Case 
        
        ALUResult = SrcA & SrcB ;  //Logical And Operation 
        if ( ALUResult )
         begin 
          ZERO = Zero  ;            //Raise the Zero Flag with one     
         end
        else
         begin 
          ZERO = ONE   ;            //Raise the Zero Flag with zero    
         end
      
      end                          //End of the And Case

//*************************** Case 001 *****************************//

OR :
      begin                        //begining of the OR Case 
        
        ALUResult = SrcA | SrcB ;  //Logical OR Operation 
        if ( ALUResult )
         begin 
          ZERO = Zero  ;            //Raise the Zero Flag with one     
         end
        else
         begin 
          ZERO = ONE   ;            //Raise the Zero Flag with zero    
         end
      
      end                          //End of the OR Case

//*************************** Case 010 *****************************//

ADDITION :

      begin                        //begining of the Addition Case  
        
        ALUResult = SrcA + SrcB ;  //Arithmatic Addition Operation  
        if ( ALUResult )
         begin 
          ZERO = Zero  ;            //Raise the Zero Flag with one     
         end
        else
         begin 
          ZERO = ONE   ;            //Raise the Zero Flag with zero      
         end
      
      end                          //End of the Addition Case

//*************************** Case 011 *****************************//

NOT_USED :

      begin 
      
      
      
      end
      
//*************************** Case 100 *****************************//
  
Subtraction :

      begin                        //begining of the Subtraction Case  
        
        ALUResult = SrcA - SrcB ;  //Arithmatic Subtraction Operation 
        if ( ALUResult )
         begin 
          ZERO = Zero ;            //Raise the Zero Flag with one       
         end
        else
         begin 
          ZERO = ONE  ;            //Raise the Zero Flag with zero     
         end
      
      end                          //End of the Subtraction Case  
      
//*************************** Case 101 *****************************//

Multblication :

      begin                         //begining of the Multblication Case  
        
        ALUResult = SrcA * SrcB ;   //Arithmatic Multblication Operation  
        if ( ALUResult )
         begin 
          ZERO = Zero  ;             //Raise the Zero Flag with one      
         end
        else
         begin 
          ZERO = ONE   ;             //Raise the Zero Flag with zero     
         end
      
      end                           //End of the Multblication Case   

//*************************** Case 110 *****************************//

SLT :

      begin                          //begining of the Comparison Case  
         
        if ( SrcA < SrcB )           //Less than Comaprison Operation 
         begin
          ALUResult = ONE  ;         //Make the Result  one    
          ZERO      = Zero ;         //Raise the Zero Flag with one         
         end
        else
         begin 
          ALUResult = Zero  ;        //Make the Result zero  
          ZERO      = ONE   ;        //Raise the Zero Flag with zero        
         end
         
      end 

//*************************** Case 111 *****************************//

NOT_USED_Again :

      begin 
      
      
      
      end
      
//************************** Case Default **************************//  

default : 
          begin 
             
            ALUResult = Zero  ;        //Make the Result zero 
            
          end 
/*********************************************************************/

 endcase         //end of the Case Statement 
end              //end of the always Block 

/*********************************************************************/

endmodule




















