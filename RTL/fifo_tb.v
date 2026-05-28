`timescale 1ns / 1ps
module tb_sync_fifo;
    reg         clk;
    reg         rst_n;
    reg         wr_en;
    reg         rd_en;
    reg  [7:0]  data_in;
    
    wire [7:0]  data_out;
    wire        full;
    wire        empty;
    sync_fifo #(
        .DEPTH(16),
        .WIDTH(8)
    ) dut (
        .clk     (clk),
        .rst_n   (rst_n),
        .wr_en   (wr_en),
        .rd_en   (rd_en),
        .data_in (data_in),
        .data_out(data_out),
        .full    (full),
        .empty   (empty)
    );
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end
    initial begin
        rst_n    = 0;
        wr_en    = 0;
        rd_en    = 0;
        data_in  = 8'h00;

        $dumpfile("sync_fifo_tb.vcd");
        $dumpvars(0, tb_sync_fifo);
        #20;
        rst_n = 1;
        #20;

        $display("\n=== TEST 1: Fill to FULL ===");
        repeat(16) begin
            @(posedge clk);
            wr_en   = 1;
            rd_en   = 0;
            data_in = data_in + 8'h11;
            #1;
            $display("t=%5t | wr=%b rd=%b | din=%h | full=%b empty=%b | count should be %0d",
                     $time, wr_en, rd_en, data_in, full, empty, dut.count);
        end

        @(posedge clk);
        wr_en = 0;
        #20;

        $display("\n=== TEST 2: Try write when FULL (should be ignored) ===");
        @(posedge clk);
        wr_en   = 1;
        data_in = 8'hFF;
        #20;
        wr_en = 0;

        $display("\n=== TEST 3: Read everything until EMPTY ===");
        repeat(16) begin
            @(posedge clk);
            wr_en   = 0;
            rd_en   = 1;
            #1;
            $display("t=%5t | wr=%b rd=%b | dout=%h | full=%b empty=%b | count should be %0d",
                     $time, wr_en, rd_en, data_out, full, empty, dut.count);
        end

        @(posedge clk);
        rd_en = 0;
        #20;

        $display("\n=== TEST 4: Try read when EMPTY (should keep old value) ===");
        @(posedge clk);
        rd_en = 1;
        #20;
        rd_en = 0;

        $display("\n=== TEST 5: Simultaneous read & write (should maintain count) ===");
        
        repeat(5) begin
            @(posedge clk);
            wr_en   = 1;
            rd_en   = 0;
            data_in = $random;
        end
        wr_en = 0; rd_en = 0; #20;

        
        $display("Starting simultaneous read+write...");
        repeat(8) begin
            @(posedge clk);
            wr_en   = 1;
            rd_en   = 1;
            data_in = $random;
            #1;
            $display("t=%5t | wr=%b rd=%b | din=%h dout=%h | full=%b empty=%b | count=%0d",
                     $time, wr_en, rd_en, data_in, data_out, full, empty, dut.count);
        end
        wr_en = 0; rd_en = 0; #20;

        $display("\n=== TEST 6: Random read/write pattern ===");
        repeat(40) begin
            @(posedge clk);
            {wr_en, rd_en} = $random;
            
            
            if (full)  wr_en = 0;
            if (empty) rd_en = 0;
            
            if (wr_en) data_in = $random;
            
            #1;
            if (wr_en || rd_en)
                $display("t=%5t | wr=%b rd=%b | din=%h dout=%h | full=%b empty=%b count=%0d ptr_wr=%0d ptr_rd=%0d",
                         $time, wr_en, rd_en, data_in, data_out, full, empty, dut.count, dut.wr_ptr, dut.rd_ptr);
        end

        #100;
        $display("\nSimulation finished.");
        $finish;
    end

    
    initial begin
        $monitor("t=%5t  wr=%b rd=%b  full=%b empty=%b  count=%2d  wptr=%2d rptr=%2d  din=%h dout=%h",
                 $time, wr_en, rd_en, full, empty, dut.count, dut.wr_ptr, dut.rd_ptr, data_in, data_out);
    end

endmodule
