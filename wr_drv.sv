class wr_drv extends uvm_driver#(wr_tx);
  `uvm_component_utils(wr_drv)
  `NEW_COMP
  virtual fifo_intf vif;
  function void build_phase(uvm_phase phase);
    uvm_resource_db#(  virtual fifo_intf)::read_by_name("GLOBAL","VIF",vif,this);
    super.build_phase(phase);
  endfunction

  task run_phase(uvm_phase phase);
    forever begin
      seq_item_port.get_next_item(req);
      drive(req);
      seq_item_port.item_done();
    end
  endtask

  task drive(wr_tx tx);
    wait(vif.rst==0);
    @(vif.wr_drv_cb);
    vif.wr_drv_cb.wen<=1;
    vif.wr_drv_cb.wdata<=tx.wdata;
    @(vif.wr_drv_cb);
    vif.wr_drv_cb.wen<=0;
    vif.wr_drv_cb.wdata<=0;
    repeat(tx.delay) @(vif.wr_drv_cb);
  endtask
endclass