`timescale 1ns / 1ps

module test;

reg clk;
reg reset_n;
wire led;

led_pwm mymodule(
    .clk(clk),
    .reset_n(reset_n),
    .led(led)
);

initial begin
    clk = 0;
    forever #5 clk = ~clk; //10ns period (100MHz)
end

initial begin
    reset_n = 0;
    #10 reset_n = 1; 
    #2000; // Run for 2000ns (20 PWM periods)
    $finish;
end

endmodule