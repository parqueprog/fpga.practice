module btn_debounce(
    input clk,
    input reset_n,
    input btnu,
    output reg [15:0] led
    );
    
    parameter MAX_COUNT_DEB = 50_000; // #0.5ms @100MHz
    parameter MAX_COUNT_SLOW = 10_000_000; // #100ms @100MHz
    
    reg btnu0, btnu1;
    reg btnu_state;
    
    reg [15:0] counter_deb = 0; // counter debouncing
    reg [23:0] counter_slow = 0; // slow counter
    reg [3:0] counter = 0; // 0-15 counter
    
    // synchronize btnu to clk domain
    always @(posedge clk or negedge reset_n) begin
        if (!reset_n) begin
            btnu0 <= 0;
            btnu1 <= 0;            
        end else begin
            btnu0 <= btnu;
            btnu1 <= btnu0;
        end
    end
    
    // debounce by using counter
    always @(posedge clk or negedge reset_n) begin
        if (!reset_n) begin
            counter_deb <= 0;
            btnu_state <= 0;            
        end else begin
            if (btnu1 != btnu_state) begin
                if (counter_deb == MAX_COUNT_DEB) begin
                    counter_deb <= 0;
                    btnu_state <= btnu1;
                 end else 
                    counter_deb <= counter_deb + 1;
            end else
                counter_deb <= 0;         
        end
    end

    // main counter: count while pressed
    always @(posedge clk or negedge reset_n) begin
        if (!reset_n) begin
            counter_slow <= 0;
            counter <= 0;            
        end else begin
            if (btnu_state) begin                        
                if (counter_slow == MAX_COUNT_SLOW) begin
                    counter_slow <= 0;    
                    if (counter == 15)
                        counter <= 0;
                    else
                        counter <= counter + 1;
                end else
                    counter_slow <= counter_slow + 1;
            end else
                counter_slow <= 0;
        end
    end
    
    always @(*) begin
        led = 16'b0000000000000000;
        led[counter] = 1;
    end

endmodule