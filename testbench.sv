// Code your testbench here
// or browse Examples
`define width 8
`define depth 16
`define add $clog2(`depth)
`include "uvm_macros.svh"
import uvm_pkg::*;
`include "fifo_common.sv"
`include "wr_tx.sv"
`include "rd_tx.sv"
`include "fifo_intf.sv"

`include "wr_drv.sv"
`include "wr_sqr.sv"
`include "wr_mon.sv"
`include "wr_cov.sv"

`include "rd_sqr.sv"
`include "rd_mon.sv"
`include "rd_drv.sv"
`include "rd_cov.sv"

`include "wr_seq.sv"
`include "rd_seq.sv"
`include "top_sqr.sv"
`include "top_seq.sv"
`include "fifo_sbd.sv"

`include "wr_agent.sv"
`include "rd_agent.sv"
`include "fifo_env.sv"
`include "fifo_test.sv"
module top;
  reg wclk,rclk,rst;
  initial begin
    wclk=0;
    forever #2 wclk=~wclk;
  end
  initial begin
    rclk=0;
    forever #5 rclk=~rclk;
  end

  initial begin
    rst=1;
    @(posedge wclk);
    @(posedge rclk);
    rst=0;
  end
  fifo_intf pif(wclk,rclk,rst);
  asy_fifo dut(
    .rst(pif.rst),
    .wen(pif.wen),
    .ren(pif.ren),
    .wclk(pif.wclk),
    .wdata(pif.wdata),
    .rdata(pif.rdata),
    .rclk(pif.rclk),
    .full(pif.full),
    .empty(pif.empty),
    .overflow(pif.overflow),
    .underflow(pif.underflow)
  );

  initial begin
    uvm_resource_db#(virtual fifo_intf)::set("GLOBAL","VIF",pif,null);
    run_test("wr_rd_test");
  end

  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0,pif);
  end
endmodule