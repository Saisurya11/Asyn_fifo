class fifo_env extends uvm_env;
  `uvm_component_utils(fifo_env)
  `NEW_COMP
  wr_agent wr;
  rd_agent rd;
  top_sqr sqr;
  fifo_sbd sbd;
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    wr=wr_agent::type_id::create("wr",this);
    rd=rd_agent::type_id::create("rd",this);
    sqr=top_sqr::type_id::create("sqr",this);
    sbd=fifo_sbd::type_id::create("sbd",this);
  endfunction
  
  function void connect_phase(uvm_phase phase);
    sqr.wr=wr.sqr;
    sqr.rd=rd.sqr;
    wr.mon.ap_port.connect(sbd.imp_write);
    rd.mon.ap_port.connect(sbd.imp_read);
  endfunction
endclass