//Author WangHuiquan
`include "timescale.v"
`include "define.h"

module SOC_TOP(
    uart_rx,
    uart_tx,
    cpu_pc,
    clk
    );
    
input   uart_rx;
output   uart_tx;
output [7:0] cpu_pc;
input   clk;
    
wire CPU_clk;
wire [7:0] cpu_pc;

wire [4:0] Dbg_reg_index;
wire [`dw-1:0] Dbg_reg_data;
wire CPU_rst;

CPU_Interface unit_cpu_interface(
      .uart_rx(uart_rx),
      .uart_tx(uart_tx),
      .clk(clk), 
      .CPU_rst(CPU_rst),
      .CPU_clk(CPU_clk),
      .Dbg_reg_index(Dbg_reg_index),
      .Dbg_reg_data(Dbg_reg_data)
      );
      
riscv_cpu_top unit_riscv_cpu(
        .clk_i(CPU_clk), 
        .rst_i(CPU_rst),
        .pc_to_debug(cpu_pc),
        .Dbg_reg_index(Dbg_reg_index), 
        .Dbg_reg_data(Dbg_reg_data)
        );

endmodule
