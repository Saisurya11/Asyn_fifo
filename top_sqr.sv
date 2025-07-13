class top_sqr extends uvm_sequencer;
  `uvm_component_utils(top_sqr)
  `NEW_COMP
  wr_sqr wr;
  rd_sqr rd;
endclass