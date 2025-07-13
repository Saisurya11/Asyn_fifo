// Code your design here
// Code your design here
module asy_fifo(rst,wen,ren,wclk,wdata,rdata,rclk,full,empty,overflow,underflow);
  parameter width=8;
  parameter depth=16;
  parameter add=$clog2(depth);
  input rst,wclk,rclk,wen,ren;
  input [width-1:0]wdata;
  output reg [width-1:0]rdata;
  output reg full=0,empty=0,overflow=0,underflow=0;

  reg [width-1:0]fifo[depth-1:0];

  reg [add:0]wptr,rptr;

  reg wflag,rflag;
  integer i;
  always@(posedge wclk)
    begin
      if(rst)
        begin
          full=0;
          empty=1;
          overflow=0;
          underflow=0;
          wptr=0;
          rptr=0;
          wflag=0;
          rflag=0;
          for(i=0;i<depth;i=i+1)
            fifo[i]='d0;
        end
      else 
        begin
          overflow=0;
          if(wen)
            begin
              if(full)
                overflow=1;
              else 
                begin
                  fifo[wptr]=wdata;
                  wptr=wptr+1;
                  if(wptr==16)
                    begin
                      wptr=0;
                      wflag=~wflag;
                    end
                end
            end
        end
    end

  always@(posedge rclk)
    begin 
      underflow=0;
      if(ren) 
        begin
          if(empty)
            underflow=1;
          else
            begin
              rdata=fifo[rptr];
              rptr=rptr+1;
              if(rptr==16) 
                begin	
                  rptr=0;
                  rflag=~rflag;
                end
            end	
        end
    end
  reg [add:0]rptr_wclk;
  reg rflag_wclk;
  always@(posedge wclk)
    begin
      rptr_wclk=rptr;
      rflag_wclk=rflag;
    end
  reg [add:0]wptr_rclk;
  reg wflag_rclk;
  always@(posedge rclk)
    begin
      wptr_rclk=wptr;
      wflag_rclk=wflag;
    end

  always@(*)
    begin
      empty=0;
      full=0;
      if(wptr_rclk==rptr && wflag_rclk==rflag)
        empty=1;
      if(rptr_wclk==wptr && rflag_wclk!=wflag)
        full=1;
    end
endmodule
