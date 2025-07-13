class rd_drv extends uvm_driver#(rd_tx);
  `uvm_component_utils(rd_drv)
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

  task drive(rd_tx tx);
    wait(vif.rst==0);
        repeat(tx.delay) @(vif.rd_drv_cb);
    @(vif.rd_drv_cb);
    vif.rd_drv_cb.ren<=1;
    @(vif.rd_drv_cb);
    vif.rd_drv_cb.ren<=0;

  endtask
endclass