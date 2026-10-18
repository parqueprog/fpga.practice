module seven_seg_counter (
   input clk,
   output reg [6:0] seg,
   output reg [7:0] an
);

   parameter MAX_COUNT = 50_000_000;
   reg [26:0] clk_counter = 0; // クロック分周器
   reg [3:0] count = 0; // 0～9のカウンター
       
   always @(posedge clk) begin
       if (clk_counter == MAX_COUNT - 1) begin
           clk_counter <= 0;
                      
           if (count == 9) // カウンターの増分
               count <= 0;
           else
               count <= count + 1;
       end else begin
           clk_counter <= clk_counter + 1;
       end
   end

   // 0～9の数字用の7セグデコーダー
   always @(*) begin
       an = 8'b11111110;  // digit 0 有効 (0 = 有効)
       case (count)
           4'd0: seg = 7'b1000000; // 0 (アクティブロー)
           4'd1: seg = 7'b1111001; // 1
           4'd2: seg = 7'b0100100; // 2
           4'd3: seg = 7'b0110000; // 3 
           4'd4: seg = 7'b0011001; // 4
           4'd5: seg = 7'b0010010; // 5
           4'd6: seg = 7'b0000010; // 6
           4'd7: seg = 7'b1111000; // 7
           4'd8: seg = 7'b0000000; // 8
           4'd9: seg = 7'b0010000; // 9
           default: seg = 7'b1111111; // すべてオフ
       endcase
   end

endmodule