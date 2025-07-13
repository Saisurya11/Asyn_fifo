class wr_agent extends uvm_agent;
  `uvm_component_utils(wr_agent)
  `NEW_COMP
  wr_mon mon;
  wr_sqr sqr;
  wr_drv drv;
  wr_cov cov;
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    drv=wr_drv::type_id::create("drv",this);
    sqr=wr_sqr::type_id::create("sqr",this);
    mon=wr_mon::type_id::create("mon",this);
    cov=wr_cov::type_id::create("cov",this);
  endfunction
  
  function void connect_phase(uvm_phase phase);
    drv.seq_item_port.connect(sqr.seq_item_export);
    mon.ap_port.connect(cov.analysis_export);
  endfunction
endclass