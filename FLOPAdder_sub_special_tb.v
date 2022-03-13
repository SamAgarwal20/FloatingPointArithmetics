module FLOPAdder_sub_special_tb();
reg [31:0] addent_t;
reg [31:0] augend_t;
wire [31:0] sum_t;

FLOPAdder_sub_special UUT(.addent(addent_t),.augend(augend_t),.result(sum_t));
initial
begin
	//$dumpfile("FLOPadder.vcd");
	//$dumpvars(FLOPadder_sub_tb,0);
	$monitor("%32b %32b %32b",addent_t,augend_t,sum_t);
	addent_t = 32'b00000000000000000000000000000000;
	augend_t = 32'b00000000000000000000000000000000;
    #10 addent_t = 32'b00000000000000000000000000000000;
	augend_t = 32'b01111111100000000000000000000000;
    #10 addent_t = 32'b00000000000000000000000000000000;
	augend_t = 32'b01111111111111111111111111111111;
    #10 addent_t = 32'b00000000000000000000000000000000;
	augend_t = 32'b01000000101010000000000000000000;
    

    #10 addent_t = 32'b01111111100000000000000000000000;
	augend_t = 32'b00000000000000000000000000000000;
    #10 addent_t = 32'b01111111100000000000000000000000;
	augend_t = 32'b11111111100000000000000000000000;
    #10 addent_t = 32'b01111111100000000000000000000000;
	augend_t = 32'b01111111111111111111111111111111;
    #10 addent_t = 32'b01111111100000000000000000000000;
	augend_t = 32'b01000000101010000000000000000000;
    
     
    #10 addent_t = 32'b01111111111111111111111111111111;
	augend_t = 32'b00000000000000000000000000000000;
    #10 addent_t = 32'b11111111111111111111111111111111;
	augend_t = 32'b01111111100000000000000000000000;
    #10 addent_t = 32'b01111111111111111111111111111111;
	augend_t = 32'b01111111111111111111111111111111;
    #10 addent_t = 32'b01111111111111111111111111111111;
	augend_t = 32'b01000000101010000000000000000000;

    #10 addent_t = 32'b01000000101010000000000000000000;
	augend_t = 32'b00000000000000000000000000000000;
    #10 addent_t = 32'b01000000101010000000000000000000;
	augend_t = 32'b01111111100000000000000000000000;
    #10 addent_t = 32'b01000000101010000000000000000000;
	augend_t = 32'b01111111111111111111111111111111;
    #10 addent_t = 32'b01000000101010000000000000000000;
	augend_t = 32'b01000000101010000000000000000000;

     
	
end
endmodule