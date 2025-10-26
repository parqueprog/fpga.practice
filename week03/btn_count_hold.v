module btn_count_hold(
    input clk,
    input reset_n,
    input btnu,
    output reg [150] led
    );
    
    parameter MAX_COUNT_SLOW = 10_000_000; 100ms @100MHz
    reg [230] counter_slow = 0;  slow counter
    reg [30] counter = 0; 0-15 counter
    
    always @(posedge clk or negedge reset_n) begin
        if (!reset_n) begin
            counter_slow = 0;
            counter = 0;       
        end else begin
            if (btnu) begin
                if (counter_slow == MAX_COUNT_SLOW) begin
                    counter_slow = 0;
                    if (counter == 15)
                        counter = 0;
                    else
                        counter = counter + 1;
                end else
                    counter_slow = counter_slow + 1;
            end
        end
    end
    
    always @() begin
        led = 16'b0000000000000000;
        led[counter] = 1;      
    end
 
endmodule