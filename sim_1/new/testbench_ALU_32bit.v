`timescale 1ns / 1ps
module test_alu();
    reg [31:0] a;
    reg [31:0] b;
    reg CI;
    reg [2:0] F;
    reg [1:0] dir;
    reg [4:0] bite;
    wire [31:0] S;
    wire CO;
    ALU_32bit uut(a,b,CI,F,dir,bite,S,CO);
    initial begin
        //F=000,25ns
        CI=0;
        F=0;
        a=0;
        b=0;
        dir=0;
        bite=0;
        #25;
        
        //add,50ns
        F=3'b001;
        a=32'b1111111;
        b=32'b11111;
        dir=0;
        bite=0;
        #25;

        //left logical shifting,75ns
        a=32'b1111111111111111111111111;
        b=0;
        F=3'b010;
        dir=2'b00;
        bite=5'b00111;
        #25;

        //right logical shifting,100ns
        a=32'b111111111111111111111111;
        b=0;
        F=3'b010;
        dir=2'b10;
        bite=5'b00011;
        #25;
        
        //left cyclic shifting,125ns
        a=32'b111111111111111111;
        b=0;
        F=3'b010;
        dir=2'b01;
        bite=5'b00111;
        #25;
        
        //right cyclic shifting,150ns
        a=32'b111111111111111111;
        b=0;
        F=3'b010;       
        dir=2'b11;
        bite=5'b00111;
        #25;
        
        //left truncation,175ns
        a=32'b111111111111111111111111111111;
        b=0;
        F=3'b011;
        dir=2'b00;
        bite=5'b11110;  
        #25;
         
        //right truncation,200ns
        a=32'b1111111111111111111111111111111;
        b=0;
        F=3'b011;
        dir=2'b10;
        bite=5'b11110;  
        #25;
          
        //and,225ns
        a=32'b1111111;
        b=32'b1110000;
        F=3'b100;
        dir=0;
        bite=0;
        #25;

        //or,250ns
        a=32'b1110110;
        b=32'b110000;
        F=3'b101;
        dir=0;
        bite=0;
        #25;

        //not,275ns
        a=32'b1111111;
        b=0;
        F=3'b110;
        dir=0;
        bite=0;
        #25;

        //xor,300ns
        a=32'b11111111;
        b=32'b1000111;
        F=3'b111;
        dir=0;
        bite=0;
        #25;
        end
endmodule

