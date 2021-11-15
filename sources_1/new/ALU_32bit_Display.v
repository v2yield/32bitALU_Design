`timescale 1ns / 1ps
module ALU_Display (
//clock and reset signal
input clk,
input resetn, 
input [2:0] input_sel, 
input sw_cin,
output led_cout,
output lcd_rst,
output lcd_cs,
output lcd_rs,
output lcd_wr,
output lcd_rd,
inout[15:0] lcd_data_io,
output lcd_bl_ctr,
inout ct_int,
inout ct_sda,
output ct_scl,
output ct_rstn
);
 //-----{Call ALU module}begin
 reg [31:0] In1;
 reg [31:0] In2;
 wire          CI;
 reg [2:0]  F;
 reg [1:0] Dir;
 reg [4:0] Bite;

 wire [31:0]   Out;
 wire          CO;
ALU_32bit alu_32(
    .a        (In1),
    .b        (In2),
    .CI         (CI),
    .F          (F),
    .dir        (Dir),
    .bite       (Bite),
    .S          (Out),
    .CO         (CO)
 );
 assign CI = sw_cin;
 assign led_cout = Out;
 //-----{Call ALU module}end

 //---------------------{Call touching screen module}begin--------------------//
 //-----{Instantiate touching screen module}begin
 //This section does not to be modified
 reg display_valid;
 reg [39:0] display_name;
 reg [31:0] display_value;
 wire [5:0] display_number;
 wire input_valid;
 wire [31:0] input_value;

lcd_module lcd_module(
 .clk (clk ), //10Mhz
 .resetn (resetn ),

 //Call interfaces of touching screen
 .display_valid (display_valid ),
 .display_name (display_name ),
 .display_value (display_value ),
 .display_number (display_number),
 .input_valid (input_valid ),
 .input_value (input_value ),

 //The interfaces of LCD touch-screen,not to be modified
 .lcd_rst (lcd_rst ),
 .lcd_cs (lcd_cs ),
 .lcd_rs (lcd_rs ),
 .lcd_wr (lcd_wr ),
 .lcd_rd (lcd_rd ),
 .lcd_data_io (lcd_data_io ),
 .lcd_bl_ctr (lcd_bl_ctr ),
 .ct_int (ct_int ),
 .ct_sda (ct_sda ),
 .ct_scl (ct_scl ),
 .ct_rstn (ct_rstn )
);
 //-----{Instantiate touching screen module}end

 //-----{Get input from the touch screen}begin
 //Modify this section as required£¬
 //When input_sel is 000, it indicates that the input number is operand1
 always @(posedge clk)
 begin
 if (!resetn)
 begin
   In1 <= 32'd0;
 end
 else if (input_valid && input_sel==3'b000 )
 begin
   In1 <= input_value;
 end
 end

 //When input_sel is 001, it indicates that the input number is operand2
always @(posedge clk)
 begin
 if (!resetn)
 begin
   In2 <= 32'd0;
 end
 else if (input_valid && input_sel==3'b001 )
 begin
   In2 <= input_value;
 end
 end
//F
always @(posedge clk)
 begin
 if (!resetn)
 begin
   F <= 3'd0;
 end
 else if (input_valid && input_sel==3'b010 )
 begin
   F <= input_value;
 end
 end

//dir
 always @(posedge clk)
 begin
 if (!resetn)
 begin
   Dir <= 2'd0;
 end
 else if (input_valid && input_sel==3'b011 )
 begin
   Dir <= input_value;
 end
 end

 //bite
 always @(posedge clk)
 begin
 if (!resetn)
 begin
   Bite <= 5'd0;
 end
 else if (input_valid && input_sel==3'b100 )
 begin
   Bite <= input_value;
 end
 end
 //-----{Get input from the touch screen}end

 //-----{Output to touch screen display}begin
 always @(posedge clk)
 begin
 case(display_number)
 6'd1 :
 begin
   display_valid <= 1'b1;       //display_valid 
   display_name <= "OP1";       //display_name 
   display_value <= In1;        //display_value 
 end
 6'd2 :
 begin
   display_valid <= 1'b1;
   display_name <= "OP2";
   display_value <= In2;
 end
 6'd3 :
 begin
   display_valid <= 1'b1;
   display_name <= "CI";
   display_value <= CI;
 end
 6'd4 :
 begin
   display_valid <= 1'b1;
   display_name <= "F";
   display_value <= F;
 end
6'd5 :
 begin
   display_valid <= 1'b1;
   display_name <= "DIR";
   display_value <= Dir;
 end
 6'd6 :
 begin
   display_valid <= 1'b1;
   display_name <= "BITE";
   display_value <= Bite;
 end
 6'd7 :
 begin
   display_valid <= 1'b1;
   display_name <= "OUT";
   display_value <= Out;
 end
 6'd8 :
 begin
   display_valid <= 1'b1;
   display_name <= "CO";
   display_value <= CO;
 end
 default :
 begin
   display_valid <= 1'b0;
   display_name <= 40'd0;
   display_value <= 32'd0;
end
endcase
end
//-----{Output to touch screen display}end
//----------------------{Call touching screen module}end---------------------//
endmodule