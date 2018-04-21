`include "timescale.v"
`include "define.h"
//`timescale 1ns/100ps

module SOC_tb;

reg clk = 1'b0;
always clk = #5 ~clk; // T = 10ns, F = 100Mhz

reg RxD = 1'b1;

wire TxD;

wire [7:0] pc;

SOC_TOP unit_SOC(
    .uart_rx(RxD),
    .uart_tx(TxD),
    .cpu_pc(pc),
    .clk(clk)
    );


task rx_send;
	input [7:0] b;
	integer i;
	begin
		RxD = 1'b0;
		for(i=1;i<8;i=i+1)
			#868 RxD = b[i];
		#868 RxD = ^b;
		#868 RxD = 1'b1;
		#868 RxD = 1'b1;
	end
endtask


initial begin
#100 SOC_tb.rx_send(8'h01);
#10000 SOC_tb.rx_send(8'hFF);
 #2000000 $stop;
end


endmodule
