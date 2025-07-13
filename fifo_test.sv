class fifo_test extends uvm_test;
  `uvm_component_utils(fifo_test)
  `NEW_COMP
  fifo_env env;
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    env=fifo_env::type_id::create("env",this);
  endfunction
endclass

class wr_rd_test extends fifo_test;
  `uvm_component_utils(wr_rd_test)
  `NEW_COMP
  top_seq seq;
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    seq=top_seq::type_id::create("seq",this);
  endfunction
  
  task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    phase.phase_done.set_drain_time(this,100);
    uvm_resource_db#(int)::set("GLOBAL","DEPTH",`depth,this);
    seq.start(env.sqr);
    phase.drop_objection(this);
  endtask
endclass

class full_test extends fifo_test;
  `uvm_component_utils(full_test)
  `NEW_COMP
  wr_normal seq;
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    seq=wr_normal::type_id::create("seq",this);
  endfunction
  
  task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    phase.phase_done.set_drain_time(this,100);
    uvm_resource_db#(int)::set("GLOBAL","DEPTH",`depth+1,this);
    seq.start(env.wr.sqr);
    phase.drop_objection(this);
  endtask
endclass

class empty_test extends fifo_test;
  `uvm_component_utils(empty_test)
  `NEW_COMP
  rd_normal seq;
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    seq=rd_normal::type_id::create("seq",this);
  endfunction
  
  task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    phase.phase_done.set_drain_time(this,100);
    uvm_resource_db#(int)::set("GLOBAL","DEPTH",4,this);
    seq.start(env.rd.sqr);
    phase.drop_objection(this);
  endtask
endclass