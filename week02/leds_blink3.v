module leds_blink3(
	input clk,        // 100MHz クロック入力
	input reset_n,    // 非同期リセット
	output reg [2:0] led  // 3つのLED出力
);

parameter MAX_COUNT0 = 100_000_000; // LED0：1秒で反転 → 2秒周期（0.5Hz点滅）
parameter MAX_COUNT1 = 50_000_000;  // LED1：0.5秒で反転 → 1秒周期（1Hz点滅）
parameter MAX_COUNT2 = 25_000_000;  // LED2：0.25秒で反転 → 0.5秒周期（2Hz点滅）

parameter N = 26;   // 27ビットカウンタ（2^27 ≈ 134,217,728）
reg [N:0] counter0;
reg [N:0] counter1;
reg [N:0] counter2;

always @(posedge clk or negedge reset_n) begin
	if (!reset_n) begin
		counter0 <= 0;
		counter1 <= 0;
		counter2 <= 0;
		led <= 3'b000;
	end else begin
	
		if (counter0 == MAX_COUNT0-1) begin
			counter0 <= 0;
			led[0] <= ~led[0];  // LEDの状態を反転
		end else begin
			counter0 <= counter0 + 1;
		end
		
		if (counter1 == MAX_COUNT1-1) begin
			counter1 <= 0;
			led[1] <= ~led[1];  // LEDの状態を反転
		end else begin
			counter1 <= counter1 + 1;
		end
		
		if (counter2 == MAX_COUNT2-1) begin
			counter2 <= 0;
			led[2] <= ~led[2];  // LEDの状態を反転
		end else begin
			counter2 <= counter2 + 1;
		end
		
	end
end

endmodule