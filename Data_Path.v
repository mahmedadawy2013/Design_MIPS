/******************************************************************************
*
* Module: Private - Data Path Block 
*
* File Name:Data_Path.v
*
* Description:  this file is used for implementation of the Data Path
*
* Author: Mohamed A. Eladawy
*
*******************************************************************************/
module Data_Path # ( 
  
parameter Instruction_Size   = 32  , //initialize a parameter variable with value 32
parameter Data_Size          = 32  , //initialize a parameter variable with value 32 
parameter ALU_Control_Width  = 3   , //initialize a parameter variable with value 3 
parameter Program_Count_Size = 32  , //initialize a parameter variable with value 32 
parameter ALU_OUT_WIDTH      = 32   ) //initialize a parameter variable with value 5

(

input wire [Instruction_Size-1:0]      Instruction_Memory_Path   , //Declaring the Variable As an Input Port with width 32 bits
input wire [Data_Size-1:0]             Data_Memory_Path          , //Declaring the Variable As an Input Port with width 32 bits 
input wire [ALU_Control_Width-1 :0]    ALU_Control_path          , //Declaring the Variable As an Output Port with width 3 bits 
input wire                             CLK_Path                  , //Declaring the Variable As an Input Port with width 1 bit 
input wire                             RST_Path                  , //Declaring the Variable As an Input Port with width 1 bit
input wire                             jumb_Path                 , //Declaring the Variable As an Output Port with width 1 bits 
//input wire                             Mem_write_Path            , //Declaring the Variable As an Output Port with width 1 bits
input wire                             Reg_write_Path            , //Declaring the Variable As an Output Port with width 1 bits
input wire                             Reg_Dest_Path             , //Declaring the Variable As an Output Port with width 1 bits
input wire                             Alu_Src_Path              , //Declaring the Variable As an Output Port with width 1 bits
input wire                             Mem_to_Reg_Path           , //Declaring the Variable As an Output Port with width 1 bits
input wire                             PC_Src_Path               , //Declaring the Variable As an Output Port with width 1 bits 
output wire [Program_Count_Size-1:0]   PC_Counter_Path           , //Declaring the Variable As an Output Port with width 32 bits 
output wire                            ZERO_Path                 , //Declaring the Variable As an Output Port with width 1 bits
output wire [ALU_OUT_WIDTH-1 :0]       ALU_OUT_Path              , //Declaring the Variable As an Output Port with width 5 bits 
output wire [Data_Size-1:0]            Write_Data_Path             //Declaring the Variable As an Input Port with width 32 bits 

);

//********************Internal Signal Declaration*****************//

wire [4:0]                             WRITE_REG_4_0   ; //Declaring the Variable As a wire  
wire [31:0]                            Result          ; //Declaring the Variable As a wire
wire [31:0]                            SrcA_Path       ; //Declaring the Variable As a wire
wire [31:0]                            SrcB_Path       ; //Declaring the Variable As a wire  
wire [31:0]                            SignLmm         ; //Declaring the Variable As a wire
wire [31:0]                            SHIFTED_Path    ; //Declaring the Variable As a wire
wire [27:0]                            SHIFTED1_Path   ; //Declaring the Variable As a wire
wire [31:0]                            PC_Branch_path  ; //Declaring the Variable As a wire
wire [31:0]                            MUX_LEFT_OUT    ; //Declaring the Variable As a wire
wire [31:0]                            PC_DASH_path    ; //Declaring the Variable As a wire
wire [31:0]                            PC_PLUS4_path   ; //Declaring the Variable As a wire          
                              
//********************************************************************//

//******************** Port Mapping For Every Block ******************//


//******************** REGISTER FILE Block Port  Mapping   ******************//

Register_File REGISTER_U (

.A1(Instruction_Memory_Path[25:21])  ,
.A2(Instruction_Memory_Path[20:16])  ,
.A3(WRITE_REG_4_0)                   ,
.WD3(Result)                         ,
.CLK(CLK_Path)                       ,
.RST(RST_Path)                       ,
.Register_Enable(Reg_write_Path)     ,
.RD1(SrcA_Path)                      ,    
.RD2(Write_Data_Path)                               
);

//******************** MUX_REGISTER_INPUT Block Port  Mapping   ******************//

MUX1 MUX_REGISTER_INPUT (

.INPUT_A(Instruction_Memory_Path[20:16])  ,
.INPUT_B(Instruction_Memory_Path[15:11])  ,
.SEL(Reg_Dest_Path)                       ,
.OUTPUT_C(WRITE_REG_4_0)

);

//******************** MUX_ALU_INPUT Block Port  Mapping   ******************//

MUX MUX_ALU_INPUT (

.INPUT_A(Write_Data_Path)  ,
.INPUT_B(SignLmm)          ,
.SEL(Alu_Src_Path)         ,
.OUTPUT_C(SrcB_Path)

);

//******************** ALU Block Port  Mapping   ******************//

ALU ALU_U (
.SrcA(SrcA_Path)                   ,
.SrcB(SrcB_Path)                   ,
.ALUControl(ALU_Control_path)      ,
.ALUResult(ALU_OUT_Path)           ,                
.ZERO(ZERO_Path )              

);

//******************** MUX_RESAULT Block Port  Mapping   ******************//

MUX MUX_RESAULT (

.INPUT_A(ALU_OUT_Path)      ,
.INPUT_B(Data_Memory_Path)  ,
.SEL(Mem_to_Reg_Path )      ,
.OUTPUT_C(Result)

);


//******************** SIGN_EXTEND Block Port  Mapping   ******************//

Sign_Extend SIGN_EXTEND_U (

.Instruction_Input(Instruction_Memory_Path[15:0]) ,
.Instruction_Extended(SignLmm)                      

);

//******************** SHIFTER Block Port  Mapping   ******************//

shift_left_twice  SHIFTER_U (

.INPUT_SHIFTED(SignLmm) ,
.OUTPUT_SHIFTED(SHIFTED_Path)                      

);

//******************** Adder Block Port  Mapping   ******************//

Adder Adder_U (

.INPUT_A(SHIFTED_Path)            ,
.INPUT_B(PC_PLUS4_path)           ,
.OUTPUT_C(PC_Branch_path)                     

);

//******************** SHIFTER Block Port  Mapping   ******************//

shift_left_twice#(.Data_Size(28)) SHIFTER1_U (

.INPUT_SHIFTED({2'b00,Instruction_Memory_Path[25:0]}) ,
.OUTPUT_SHIFTED(SHIFTED1_Path)                      

);

//******************** MUX_LEFT Block Port  Mapping   ******************//

MUX MUX_LEFT (

.INPUT_A(PC_PLUS4_path)            ,
.INPUT_B(PC_Branch_path)           ,
.SEL(PC_Src_Path)                  ,
.OUTPUT_C(MUX_LEFT_OUT )

);

//******************** MUX_LEFT1 Block Port  Mapping   ******************//

MUX MUX_LEFT1 (

.INPUT_A(MUX_LEFT_OUT)                                         ,
.INPUT_B({PC_PLUS4_path[31:28],SHIFTED1_Path[27:0]}) ,
.SEL(jumb_Path)                                                ,
.OUTPUT_C(PC_DASH_path)

);

//******************** Program Counter Block Port  Mapping   ******************//

program_Counter PROGRAM_COUNTER_U (

.Program_Counter_input(PC_DASH_path )    ,                                        
.Program_Counter_output(PC_Counter_Path) ,
.CLK(CLK_Path)                           ,                                              
.RST(RST_Path)

);

//******************** Adder Block Port  Mapping   ******************//

Adder Adder_U1 (

.INPUT_A(PC_Counter_Path)  ,
.INPUT_B(32'd4)            ,
.OUTPUT_C(PC_PLUS4_path)                     

);









endmodule 
