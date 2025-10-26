module leds_pwm(
    input clk,
    input reset_n,
    output reg [5:0] led
    );
    
    parameter MAX_COUNT = 100;    
    reg [7:0] counter = 0;
    
    always @(posedge clk or negedge reset_n) begin
    
        if (!reset_n) begin
            counter <= 0;
            led <= 6'b000000;            
        end else begin
    
            if (counter == MAX_COUNT - 1)
                counter <= 0;
            else
                counter <= counter + 1;
                
            led[0] <= (counter < 5)? 1: 0;
            led[1] <= (counter < 20)? 1: 0;
            led[2] <= (counter < 40)? 1: 0;
            led[3] <= (counter < 60)? 1: 0;
            led[4] <= (counter < 80)? 1: 0;
            led[5] <= (counter < 100)? 1: 0;
        end
    end

endmodule