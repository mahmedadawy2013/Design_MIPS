/******************************************************************************
*
* Module: Private - MIPS Processor
*
* File Name:MiPs.v
*
* Description:  this file is used for implementation of the Data Path
*
* Author: Mohamed A. Eladawy
*
*******************************************************************************/
module MIPS_Processor (

input wire                             CLK_Processor                  , //Declaring the Variable As an Input Port with width 1 bit 
input wire                             RST_Processor                  , //Declaring the Variable As an Input Port with width 1 bit
output wire [15:0]                     Test_Value                       //Declaring the Variable As an Input Port with width 32 bits 

);

//****************** Parameeters Initialization  ****************//

localparam         Out_Width           = 32 ;            //initialize a parameter variable with a binary value 32

//********************Internal Signal Declaration*****************//

wire                                   memWrite_wire    ; //Declaring the Variable As a wire 
wire                                   memtoReg_wire    ; //Declaring the Variable As a wire 
wire                                   jump_wire        ; //Declaring the Variable As a wire 
wire                                   ALU_src_wire     ; //Declaring the Variable As a wire 
wire                                   reg_write_wire   ; //Declaring the Variable As a wire 
wire                                   reg_dest_wire    ; //Declaring the Variable As a wire 
wire                                   zero_wire        ; //Declaring the Variable As a wire 
wire                                   PC_src_wire      ; //Declaring the Variable As a wire
wire [2:0]                             ALU_control_wire ; //Declaring the Variable As a wire
wire [Out_Width-1:0]                   PC_wire          ; //Declaring the Variable As a wire 
wire [Out_Width-1:0]                   ALU_out_wire     ; //Declaring the Variable As a wire 
wire [Out_Width-1:0]                   write_data_wire  ; //Declaring the Variable As a wire
wire [Out_Width-1:0]                   RAM_RD_wire      ; //Declaring the Variable As a wire
wire [Out_Width-1:0]                   ROM_RD_wire      ; //Declaring the Variable As a wire
       
                              
//********************************************************************//

//******************** Port Mapping For Every Block ******************//


//******************** Control Unit Block Port  Mapping   ******************//

Control_Unit CONTROL_U ( //Instantiation of the control unit.

.Op_Code(ROM_RD_wire[31:26])   ,
.Funct(ROM_RD_wire[5:0])       ,
.zero(zero_wire)               ,
.jumb(jump_wire)               ,
.Mem_to_Reg(memtoReg_wire)     ,
.Mem_write(memWrite_wire)      ,
.Alu_Src (ALU_src_wire)        ,
.Reg_Dest(reg_dest_wire)       ,
.Reg_write (reg_write_wire)    ,
.ALU_Control(ALU_control_wire) ,
.PC_src (PC_src_wire)

);

//******************** DATA PATH Block Port  Mapping   ******************//

Data_Path DATA_PATH_U( //Instantiation of the data path block.

.CLK_Path (CLK_Processor )             ,
.RST_Path (RST_Processor)              ,
.Instruction_Memory_Path(ROM_RD_wire)  ,
.Data_Memory_Path(RAM_RD_wire)         ,
.jumb_Path(jump_wire)                  ,
.PC_Src_Path (PC_src_wire)             ,
.Mem_to_Reg_Path (memtoReg_wire)       ,
.Alu_Src_Path (ALU_src_wire)           , 
.Reg_Dest_Path (reg_dest_wire)         ,
.Reg_write_Path(reg_write_wire)        ,
.ALU_Control_path(ALU_control_wire)    ,
.PC_Counter_Path(PC_wire)              ,
.ALU_OUT_Path(ALU_out_wire)            ,
.Write_Data_Path(write_data_wire)      ,
.ZERO_Path(zero_wire)

);

//******************** DATA MEMORY Block Port  Mapping   ******************//

Data_Memory DATA_MEMORY_U ( //Instantiation of the DATA_MEMORY block.

.Address_Data_memory(ALU_out_wire)  ,
.Write_Data_memory(write_data_wire) ,
.Write_Enable_memory(memWrite_wire)                  ,
.CLK(CLK_Processor )                ,
.RST(RST_Processor)                 ,
.Read_Data_memory(RAM_RD_wire)      ,
.TEST_RESULT(Test_Value )

);

//******************** INSTRUCTION MEMORY Block Port  Mapping   ******************//


Instruction_Memory INSTRUCTION_MEMORY_U ( //Instantiation of the Instruction_Memory block.

.PC_Input(PC_wire)  ,
.Instrucion_output(ROM_RD_wire)

);


endmodule 

