class wr_tx extends uvm_sequence_item;
  logic wen;
  rand logic [`width-1:0]wdata;
  logic overflow;
  logic underflow;
  logic full;
  logic empty;
  rand bit[2:0] delay;

  `uvm_object_utils_begin(wr_tx)
  `uvm_field_int(wen,UVM_ALL_ON)
  `uvm_field_int(wdata,UVM_ALL_ON)
  `uvm_field_int(overflow,UVM_ALL_ON)
  `uvm_field_int(underflow,UVM_ALL_ON)
  `uvm_field_int(full,UVM_ALL_ON)
  `uvm_field_int(empty,UVM_ALL_ON)
  `uvm_object_utils_end
  `NEW_OBJ

endclass