class rd_mon extends uvm_monitor;
  `uvm_component_utils(rd_mon)
  `NEW_COMP
  virtual fifo_intf vif;
  uvm_analysis_port#(rd_tx) ap_port;
  function void build_phase(uvm_phase phase);
    uvm_resource_db#(  virtual fifo_intf)::read_by_name("GLOBAL","VIF",vif,this);
    super.build_phase(phase);
    ap_port=new("ap_port",this);
  endfunction

  task run_phase(uvm_phase phase);
    forever begin
      @(vif.rd_mon_cb);
      if(vif.rd_mon_cb.ren) begin
        rd_tx tx=rd_tx::type_id::create("tx");
                $display($time);

        tx.ren=vif.rd_mon_cb.ren;
        tx.rdata=vif.rd_mon_cb.rdata;
        tx.overflow=vif.rd_mon_cb.overflow;
        tx.underflow=vif.rd_mon_cb.underflow;
        tx.full=vif.rd_mon_cb.full;
        tx.empty=vif.rd_mon_cb.empty;
        ap_port.write(tx);
        //         tx.print();
      end
    end
  endtask
endclass