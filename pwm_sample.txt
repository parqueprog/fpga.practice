module led_pwm(
    input clk,
    input reset_n,
    output reg led
    );
    
    parameter MAX_COUNT = 100;
    parameter DUTY_CYCLE = 20;
    reg [7:0] counter = 0;
    
    always @(posedge clk or negedge reset_n) begin
        if (!reset_n) begin
            counter <= 0;
            led <= 0;
        end begin            
            if (counter == MAX_COUNT - 1)
                counter <= 0;
            else
                counter <= counter + 1;
                
            led <= (counter < DUTY_CYCLE)? 1: 0;
        end
    end
        
endmodule