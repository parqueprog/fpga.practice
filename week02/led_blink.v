module led_blink #(
	parameter MAX_COUNT = 27'd100_000_000, // 27ビット d: decimal 100,000,000
	parameter N = 26   // 27ビットカウンタ（2^26 = 67,108,864  vs 2^27 = 134,217,728）
)(
	input clk,        // 100MHz クロック入力
	input reset_n,    // 非同期リセット
	output reg led    // LED出力
);

reg [N:0] counter;	// 27ビットカウンタ

always @(posedge clk or negedge reset_n) begin
	if (!reset_n) begin
		counter <= 0;
		led <= 0;
	end else begin
		if (counter == MAX_COUNT-1) begin
			counter <= 0;
			led <= ~led;  // LEDの状態を反転
		end else begin
			counter <= counter + 1;
		end
	end
end

endmodule