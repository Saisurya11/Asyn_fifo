class rd_agent extends uvm_agent;
  `uvm_component_utils(rd_agent)
  `NEW_COMP
  rd_mon mon;
  rd_sqr sqr;
  rd_drv drv;
  rd_cov cov;
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    drv=rd_drv::type_id::create("drv",this);
    sqr=rd_sqr::type_id::create("sqr",this);
    mon=rd_mon::type_id::create("mon",this);
    cov=rd_cov::type_id::create("cov",this);
  endfunction
  
  function void connect_phase(uvm_phase phase);
    drv.seq_item_port.connect(sqr.seq_item_export);
    mon.ap_port.connect(cov.analysis_export);
  endfunction
endclass