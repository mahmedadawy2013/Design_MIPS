/******************************************************************************
* Module: Private - Control Unit Block 
*
* File Name: Control_Unit.v
*
* Description: The control unit computes the control signals based on the opcode
*              and funct fields of the instruction, Instr31:26 and Instr5:0. Most
*              of the control information comes from the opcode, but R-type instructions
*              also use the funct field to determine the ALU operation. Thus, we will simplify
*              our design by factoring the control unit into two blocks of combinational logic
*
* Author: Mohamed A. Eladawy
*
*******************************************************************************/
//********************Port Declaration*************************//

module Control_Unit #(

parameter Op_Code_Width     = 6 , //initialize a parameter variable with value 6
parameter ALU_Control_Width = 3 , //initialize a parameter variable with value 3 
parameter Funct_Width       = 6 ) //initialize a parameter variable with value 6 

(

input wire [Op_Code_Width-1 :0]     Op_Code        , //Declaring the Variable As an Input Port with width 5 bits
input wire [Funct_Width-1   :0]     Funct          , //Declaring the Variable As an Input Port with width 5 bits
input wire                          zero           , //Declaring the Variable As an Input Port with width 5 bits
output reg [ALU_Control_Width-1 :0] ALU_Control    , //Declaring the Variable As an Output Port with width 3 bits 
output reg                          jumb           , //Declaring the Variable As an Output Port with width 1 bits 
output reg                          Mem_write      , //Declaring the Variable As an Output Port with width 1 bits
output reg                          Reg_write      , //Declaring the Variable As an Output Port with width 1 bits
output reg                          Reg_Dest       , //Declaring the Variable As an Output Port with width 1 bits
output reg                          Alu_Src        , //Declaring the Variable As an Output Port with width 1 bits
output reg                          Mem_to_Reg     , //Declaring the Variable As an Output Port with width 1 bits
          //Declaring the Variable As an Output Port with width 1 bits
output wire                         PC_src           //Declaring the Variable As an Output Port with width 1 bits


); 
reg                          Branch;
//****************** Parameeters Initialization  ****************//

localparam         ZERO           = 1'b0       ,            //initialize a parameter variable with a binary value 0
                   ONE            = 1'b1       ,            //initialize a parameter variable with a binary value 1
                   ZERO_ZERO      = 2'b00      ,            //initialize a parameter variable with a binary value 00
                   ZERO_ONE       = 2'b01      ,            //initialize a parameter variable with a binary value 01
                   ONE_ZERO       = 2'b10      ,            //initialize a parameter variable with a binary value 10
                   ONE_ONE        = 2'b10      ,            //initialize a parameter variable with a binary value 11
                   Add            = 6'b10_0000 ,            //initialize a parameter variable with a binary value 100000
                   Sub            = 6'b10_0010 ,            //initialize a parameter variable with a binary value 100010
                   Slt            = 6'b10_1010 ,            //initialize a parameter variable with a binary value 101010
                   Mul            = 6'b01_1100 ,            //initialize a parameter variable with a binary value 011100
                   Load_word      = 6'b10_0011 ,            //initialize a parameter variable with a binary value 100011
                   Store_word     = 6'b10_1011 ,            //initialize a parameter variable with a binary value 101011
                   R_Type         = 6'b00_0000 ,            //initialize a parameter variable with a binary value 000000
                   Add_Immediate  = 6'b00_1000 ,            //initialize a parameter variable with a binary value 001000
                   BranchIf_Equal = 6'b00_0100 ,            //initialize a parameter variable with a binary value 000100
                   Jumb_Inst      = 6'b00_0010 ,            //initialize a parameter variable with a binary value 000010
                   ALU_OP_Width   = 2          ;            //initialize a parameter variable with a Decimal value 32                   

//********************Internal Signal Declaration*****************//

reg [ ALU_OP_Width-1 :0]  Alu_op ;                           //Declaring The Variable To Use it As a register Inside The Always Block

//*************************** The RTL Code *****************************//

assign PC_src = Branch & zero ;

//**************** Starting Combinational Always Block *****************//

//****************** Main Deacoder Implementation ********************// 

always @ (*) 

begin 

case (Op_Code)
  
Load_word :
            begin 
             
                 jumb       = ZERO      ;
                 Alu_op     = ZERO_ZERO ;        
                 Mem_write  = ZERO      ;   
                 Reg_write  = ONE       ;                   
                 Reg_Dest   = ZERO      ;
                 Alu_Src    = ONE       ;
                 Mem_to_Reg = ONE       ;
                 Branch     = ZERO      ;
              
            end 

Store_word :
            begin 
             
                 jumb       = ZERO      ;
                 Alu_op     = ZERO_ZERO ;        
                 Mem_write  = ONE       ;   
                 Reg_write  = ZERO      ;                    
                 Reg_Dest   = ZERO      ; 
                 Alu_Src    = ONE       ;
                 Mem_to_Reg = ONE       ;
                 Branch     = ZERO      ;
              
            end 

R_Type :
            begin 
             
                 jumb       = ZERO      ;
                 Alu_op     = ONE_ZERO  ;          
                 Mem_write  = ZERO      ;   
                 Reg_write  = ONE       ;                    
                 Reg_Dest   = ONE       ; 
                 Alu_Src    = ZERO      ;
                 Mem_to_Reg = ZERO      ;
                 Branch     = ZERO      ;
              
            end 

Add_Immediate :
           
            begin 
             
                 jumb       = ZERO      ;
                 Alu_op     = ZERO_ZERO ;          
                 Mem_write  = ZERO      ;   
                 Reg_write  = ONE       ;                    
                 Reg_Dest   = ZERO      ; 
                 Alu_Src    = ONE       ;
                 Mem_to_Reg = ZERO      ;
                 Branch     = ZERO      ;
              
            end

BranchIf_Equal :
           
            begin 
             
                 jumb       = ZERO      ;
                 Alu_op     = ZERO_ONE  ;             
                 Mem_write  = ZERO      ;   
                 Reg_write  = ZERO      ;                    
                 Reg_Dest   = ZERO      ; 
                 Alu_Src    = ZERO      ;
                 Mem_to_Reg = ZERO      ;
                 Branch     = ONE       ; 
              
            end

Jumb_Inst :
           
            begin 
             
                 jumb       = ONE       ; 
                 Alu_op     = ZERO_ZERO ;           
                 Mem_write  = ZERO      ;   
                 Reg_write  = ZERO      ;                    
                 Reg_Dest   = ZERO      ; 
                 Alu_Src    = ZERO      ;
                 Mem_to_Reg = ZERO      ;
                 Branch     = ZERO      ;
              
            end

default :
           
            begin 
             
                 jumb       = ZERO      ; 
                 Alu_op     = ZERO_ZERO ;           
                 Mem_write  = ZERO      ;   
                 Reg_write  = ZERO      ;                    
                 Reg_Dest   = ZERO      ; 
                 Alu_Src    = ZERO      ;
                 Mem_to_Reg = ZERO      ;
                 Branch     = ZERO      ;
              
            end


 endcase  
end 

//****************** ALU Deacoder Implementation ********************// 

always @ (*) 

begin 

case ( Alu_op )

ZERO_ZERO : 

        begin 
          
            ALU_Control = 3'b010 ; 
          
        end 

ZERO_ONE : 

        begin 
          
            ALU_Control = 3'b100 ; 
          
        end 

ONE_ZERO : 

        begin 
          
          if ( Funct == Add ) 
          
             begin 
             
                 ALU_Control = 3'b010 ; 
             
             end 
             
          else if  ( Funct == Sub )
                       
             begin 
             
                 ALU_Control = 3'b100 ; 
             
             end
        
         else if  ( Funct == Slt )
                       
             begin 
             
                 ALU_Control = 3'b110 ; 
             
             end
        
         else if  ( Funct == Mul )
                       
             begin 
             
                 ALU_Control = 3'b101 ; 
             
             end 
             
        else   
             
             
             begin 
             
                 
             
             end 
      end   
       
       
    default : 
            
             begin 
             
                 ALU_Control = 3'b010 ; 
             
             end                   
    endcase
end        

//***********************************************************************************//

endmodule