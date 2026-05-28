`timescale 1ns / 1ps
module sync_fifo (clk,rst_n,wr_en,rd_en,data_in,data_out,full,empty);
input  wire clk;
input  wire rst_n;
input  wire wr_en;
input  wire rd_en;
input  wire [7:0]  data_in;
output reg  [7:0]  data_out;
output wire full;
output wire empty;

parameter DEPTH = 16;
parameter WIDTH = 8;

localparam ADDR_W = $clog2(DEPTH);

reg [WIDTH-1:0] mem [0:DEPTH-1];
reg [ADDR_W-1:0] wr_ptr, rd_ptr;
reg [ADDR_W:0]   count;

always @(posedge clk) begin
if (!rst_n) begin
    wr_ptr   <= 0;
    rd_ptr   <= 0;
    count    <= 0;
    data_out <= 0;
    end 
else begin
case ({wr_en && !full, rd_en && !empty})
    2'b10: begin // write only
           mem[wr_ptr] <= data_in;
           wr_ptr <= wr_ptr + 1;
           count  <= count + 1;
           end
    2'b01: begin // read only
           data_out <= mem[rd_ptr];
           rd_ptr <= rd_ptr + 1;
           count  <= count - 1;
           end
    2'b11: begin // simultaneous read & write
           mem[wr_ptr] <= data_in;
           data_out <= mem[rd_ptr];
           wr_ptr <= wr_ptr + 1;
           rd_ptr <= rd_ptr + 1;
                // count unchanged
           end
endcase
end
end

assign empty = (count == 0);
assign full  = (count == DEPTH);

endmodule
