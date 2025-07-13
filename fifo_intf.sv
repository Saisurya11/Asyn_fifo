interface fifo_intf(input wclk,rclk,rst);
  logic wen=0,ren=0;
  logic [`width-1:0]wdata=0;
  logic [`width-1:0]rdata;
  logic full,empty,overflow,underflow;

  clocking wr_drv_cb@(posedge wclk);
    default input #0 output #1;
    output wen,wdata;
    input full,empty,overflow,underflow;
  endclocking

  clocking rd_drv_cb@(posedge rclk);
    default input #0 output #1;
    output ren;
    input rdata;
    input full,empty,overflow,underflow;
  endclocking

  clocking wr_mon_cb@(posedge wclk);
    default input #1;
    input wen,wdata;
    input full,empty,overflow,underflow;
  endclocking

  clocking rd_mon_cb@(posedge rclk);
    default input #0;
    input ren;
    input rdata;
    input full,empty,overflow,underflow;
  endclocking
endinterface
