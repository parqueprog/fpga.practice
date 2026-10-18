`timescale 1ns/1ps

module led_blink_tb;

// テストベンチ信号
reg clk;
reg reset_n;
wire led;

// シミュレーションでは、計数器の最大値（MAX_COUNT）を小さく設定します
parameter MAX_COUNT_TB = 4'd9;
parameter N_TB = 3; // 4ビットカウンタ   

// DUT（Device Under Test、テスト対象デバイス）をインスタンス化する
led_blink #(
	.MAX_COUNT(MAX_COUNT_TB),
	.N(N_TB)
) dut (
	.clk(clk),
	.reset_n(reset_n),
	.led(led)
);

// 100 MHz（10 ns周期）のクロックを生成
initial clk = 0;
always #5 clk = ~clk; // 5ナノ秒ごとに信号を切り替える

// Test sequence
initial begin
	// Reset 
	reset_n = 0;
	#20;               // リセット信号を20ナノ秒間Lowレベルに保持する
	reset_n = 1;       // リセット信号を解除する
	
	// シミュレーションを実行 (ナノ秒)
	#200_000_000;      // 200ミリ秒シミュレーション
	$finish;
end

endmodule