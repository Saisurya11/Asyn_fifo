class wr_seq extends uvm_sequence#(wr_tx);
  `uvm_object_utils(wr_seq)
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

class wr_normal extends wr_seq;
  `uvm_object_utils(wr_normal)
  `NEW_OBJ
  int depth;
  task body();
    uvm_resource_db#(int)::read_by_name("GLOBAL","DEPTH",depth,this);
    repeat(depth) begin
      wr_tx tx=wr_tx::type_id::create("tx");
      `uvm_do(req)
    end
  endtask
endclass