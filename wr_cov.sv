class wr_cov extends uvm_subscriber#(wr_tx);
  `uvm_component_utils(wr_cov)
  wr_tx tx[$],temp_tx,temp;
  covergroup wr_fifo_cg;
    en: coverpoint temp.wen{
      bins wen_active={1'b1};
      bins wen_not_active={1'b0};
    }
    full: coverpoint temp.full{
      bins FULL={1'b1};
      bins not_FULL={1'b0};
    }
    empty: coverpoint temp.empty;
    overflow: coverpoint temp.overflow;
    underflow: coverpoint temp.underflow;
    cross_en_full: cross en,full{
      bins  wr_not_full=binsof(en.wen_active) && binsof(full.not_FULL);
      bins  wr_full=binsof(en.wen_active) && binsof(full.FULL);
    }
  endgroup
  
  function new(string name="",uvm_component parent);
    super.new(name,parent);
    wr_fifo_cg=new();
  endfunction
  
  function void write(T t);
    $cast(temp_tx,t);
    tx.push_back(temp_tx);
  endfunction
  
  task run_phase(uvm_phase phase);
    forever begin
      wait(tx.size()>0);
      temp=tx.pop_front();
      wr_fifo_cg.sample();
    end
  endtask
  
  function void report_phase(uvm_phase phase);
    `uvm_info("WR_COVERAGE",$psprintf("coverage=%.3f",wr_fifo_cg.get_inst_coverage()),UVM_NONE)
  endfunction
endclass