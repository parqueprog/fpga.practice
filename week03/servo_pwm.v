module servo_pwm(
    input clk,
    output reg servo
    );
    
    parameter MAX_COUNT = 2_000_000; // #cycles for 20ms @100MHz
    parameter MIN_DUTY_CYCLE = 100_000; // #cycles for 1ms @100MHz
    parameter MAX_DUTY_CYCLE = 200_000; // #cycles for 2ms @100MHz    
    parameter STOP_DUTY_CYCLE = 150_000; // #cycles for 1.5ms @100MHz    
    
    reg [20:0] counter_pwm = 0;
    reg [20:0] duty_cycle = MIN_DUTY_CYCLE;
    
    always @(posedge clk) begin
    
        if (counter_pwm == MAX_COUNT - 1)
            counter_pwm <= 0;
        else
            counter_pwm <= counter_pwm + 1;
            
        servo <= (counter_pwm < duty_cycle) ? 1 : 0;
            
    end
    
endmodule