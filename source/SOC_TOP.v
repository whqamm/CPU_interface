//Author WangHuiquan
`include "timescale.v"
`include "define.h"

module SOC_TOP(
    input   uart_rx,
    output   uart_tx,
    output [7:0] cpu_pc,
    input   clk
    );
    
wire CPU_clk;
wire [7:0] cpu_pc;

CPU_Interface unit_cpu_interface(
      .uart_rx(uart_rx),
      .uart_tx(uart_tx),
      .clk(clk), 
      .CPU_clk(CPU_clk)
      );
      
riscv_cpu_top unit_riscv_cpu(
        .clk_i(CPU_clk), 
        .rst_i(1'b0),
        .pc_to_debug(cpu_pc)
        );

endmodule
