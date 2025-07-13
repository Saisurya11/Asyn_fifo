class rd_tx extends uvm_sequence_item;
  logic ren;
  logic [`width-1:0]rdata;
  logic overflow;
  logic underflow;
  logic full;
  logic empty;
  int tim=$time;
  rand bit[2:0] delay;
  `uvm_object_utils_begin(rd_tx)
  `uvm_field_int(ren,UVM_ALL_ON)
  `uvm_field_int(rdata,UVM_ALL_ON)
  `uvm_field_int(overflow,UVM_ALL_ON)
  `uvm_field_int(underflow,UVM_ALL_ON)
  `uvm_field_int(full,UVM_ALL_ON)
  `uvm_field_int(empty,UVM_ALL_ON)
  `uvm_field_int(tim,UVM_ALL_ON)
  `uvm_object_utils_end
  `NEW_OBJ
  
  constraint a_c{
    delay inside {[2:7]};
  }

endclass