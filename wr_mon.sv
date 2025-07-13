class wr_mon extends uvm_monitor;
  `uvm_component_utils(wr_mon)
  `NEW_COMP
  virtual fifo_intf vif;
  uvm_analysis_port#(wr_tx) ap_port;
  function void build_phase(uvm_phase phase);
    uvm_resource_db#(  virtual fifo_intf)::read_by_name("GLOBAL","VIF",vif,this);
    super.build_phase(phase);
    ap_port=new("ap_port",this);
  endfunction

  task run_phase(uvm_phase phase);
    forever begin
      @(vif.wr_mon_cb);
      if(vif.wr_mon_cb.wen) begin
        wr_tx tx=wr_tx::type_id::create("tx");
        tx.wen=vif.wr_mon_cb.wen;
        tx.wdata=vif.wr_mon_cb.wdata;
        tx.overflow=vif.wr_mon_cb.overflow;
        tx.underflow=vif.wr_mon_cb.underflow;
        tx.full=vif.wr_mon_cb.full;
        tx.empty=vif.wr_mon_cb.empty;
        ap_port.write(tx);
//         tx.print();
      end
    end
  endtask
endclass