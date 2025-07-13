class rd_seq extends uvm_sequence#(rd_tx);
  `uvm_object_utils(rd_seq)
  `NEW_OBJ
  uvm_phase phase;
  task pre_body();
    phase =get_starting_phase();
    if(phase!=null) begin
      phase.raise_objection(this);
      phase.phase_done.set_drain_time(this,100);
    end
  endtask

  task post_body();
    if(phase!=null) begin
      phase.drop_objection(this);
    end
  endtask
endclass

class rd_normal extends rd_seq;
  `uvm_object_utils(rd_normal)
  `NEW_OBJ
  int depth;
  task body();
    uvm_resource_db#(int)::read_by_name("GLOBAL","DEPTH",depth,this);
    repeat(depth) begin
      rd_tx tx=rd_tx::type_id::create("tx");
      `uvm_do(req)
    end
  endtask
endclass