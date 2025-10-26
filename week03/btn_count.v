module btn_count(
    input clk,
    input reset_n,
    input btnu,
    output reg [15:0] led
    );
    
    reg btnu_prev;
    reg [3:0] counter = 0; //0-15 counter
    
    always @(posedge clk or negedge reset_n) begin
    
        if (!reset_n) begin
            counter <= 0;
            btnu_prev <= 0;               
        end else begin
            btnu_prev <= btnu;
            if (btnu & ~btnu_prev) begin            
                if (counter == 15)
                    counter <= 0;
                else
                    counter <= counter + 1;
            end
        end 
    end
    
    always @(*) begin
        led = 16'b0000000000000000;
        led[counter] = 1;      
    end
endmodule