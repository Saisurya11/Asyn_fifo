class top_seq extends uvm_sequence;
  `uvm_object_utils(top_seq)
  `NEW_OBJ
  `uvm_declare_p_sequencer(top_sqr)
  wr_normal wr;
  rd_normal rd;
  task body();
    fork
    `uvm_do_on(wr,p_sequencer.wr)
    `uvm_do_on(rd,p_sequencer.rd)
    join
  endtask
endclass