module seven_seg_counter_199 (
    input clk,
    output reg [6:0] seg,
    output reg [7:0] an
);

    parameter MAX_COUNT = 50_000_000; // カウンターの値更新用（1秒間隔のクロック分周）
    reg [26:0] clk_counter = 0; 
    
    // 0から199まで数える値カウンター
    reg [7:0] value_count = 0; 

    // 百の位、十の位、一の位に分離
    wire [3:0] digit_hundreds = value_count / 100;
    wire [3:0] digit_tens     = (value_count / 10) % 10;
    wire [3:0] digit_ones     = value_count % 10;

    // ダイナミック点灯用スキャンカウンター（約1kHzでリフレッシュ）
    reg [19:0] mux_counter = 0;
    reg [1:0] display_sel = 0;

    // 現在表示している桁の数値を一時保持するレジスタ
    reg [3:0] current_digit;

    // 1. 値のインクリメント処理（1秒ごとに0〜199までカウント）
    always @(posedge clk) begin
        if (clk_counter == MAX_COUNT - 1) begin
            clk_counter <= 0;
            if (value_count == 199)
                value_count <= 0;
            else
                value_count <= value_count + 1;
        end else begin
            clk_counter <= clk_counter + 1;
        end
    end

    // 2. ダイナミック点灯のスキャンカウンター
    always @(posedge clk) begin
        mux_counter <= mux_counter + 1;
        if (mux_counter == 0) begin
            display_sel <= display_sel + 1; 
            if (display_sel >= 2)
                display_sel <= 0;
        end
    end

    // 3. 表示する桁の選択とアノードの有効化（アクティブロー）
    always @(*) begin
        an = 8'b11111111; // デフォルト：全アノードオフ（消灯）
        case (display_sel)
            2'd0: begin
                an = 8'b11111110;           // AN0有効（一の位）
                current_digit = digit_ones;
            end
            2'd1: begin
                an = 8'b11111101;           // AN1有効（十の位）
                current_digit = digit_tens;
            end
            2'd2: begin
                an = 8'b11111011;           // AN2有効（百の位）
                current_digit = digit_hundreds;
            end
            default: begin
                an = 8'b11111111;
                current_digit = 4'd0;
            end
        endcase
    end

    // 4. 選択された桁の数字用 7セグメントデコーダー（アクティブロー）
    always @(*) begin
        case (current_digit)
            4'd0: seg = 7'b1000000; // 0
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