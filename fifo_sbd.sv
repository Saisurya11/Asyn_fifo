class fifo_sbd extends uvm_scoreboard;
  `uvm_component_utils(fifo_sbd)
  `NEW_COMP
  `uvm_analysis_imp_decl(_write)
  `uvm_analysis_imp_decl(_read)
  uvm_analysis_imp_write#(wr_tx,fifo_sbd) imp_write;
  uvm_analysis_imp_read#(rd_tx,fifo_sbd) imp_read;
  wr_tx tx_wr[$],temp_wr;
  rd_tx tx_rd[$],temp_rd;
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    imp_write=new("imp_write",this);
    imp_read=new("imp_read",this);
  endfunction

  function void write_write(wr_tx tx);
    tx_wr.push_back(tx);
  endfunction

  function void write_read(rd_tx tx);
    tx_rd.push_back(tx);
  endfunction
  int match,mis_match;
  task run_phase(uvm_phase phase);
    forever begin
      wait(tx_wr.size()>0 && tx_rd.size()>0);
      temp_wr=tx_wr.pop_front();      
      temp_rd=tx_rd.pop_front();
//       temp_rd.print();
//       $display("%0p",temp_wr);
//       $display("%0p",temp_rd);
      if(temp_wr.wdata==temp_rd.rdata) begin
                $display("write=%0d,read=%0d",temp_wr.wdata,temp_rd.rdata);
        match++;
      end
      else begin
        $display("write=%0d,read=%0d",temp_wr.wdata,temp_rd.rdata);
        mis_match++;
      end
    end
  endtask

  function void report_phase(uvm_phase phase);
    `uvm_info("MATCH",$psprintf("matches=%0d",match),UVM_NONE)
    `uvm_info("MIS_MATCH",$psprintf("mis_matches=%0d",mis_match),UVM_NONE)
  endfunction
endclass