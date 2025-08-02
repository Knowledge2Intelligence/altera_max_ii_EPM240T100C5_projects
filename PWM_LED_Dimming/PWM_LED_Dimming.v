module pwm_led_fade (
    input clk,           // 50MHz clock
    output reg led1,
    output reg led2,
    output reg led3
);

    reg [7:0] brightness = 0;        // Brightness value (0–255)
    reg direction = 1'b1;            // 1 = increasing, 0 = decreasing
    reg [20:0] delay_counter = 0;    // Enough for ~30ms delay
    reg [7:0] pwm_counter = 0;       // 8-bit PWM counter

    // PWM counter runs fast
    always @(posedge clk) begin
        pwm_counter <= pwm_counter + 1;
    end

    // Brightness step every ~30ms
    always @(posedge clk) begin
        delay_counter <= delay_counter + 1;

        if (delay_counter >= 21'd1_500_000) begin  // ~30ms at 50MHz
            delay_counter <= 0;

            if (direction)
                brightness <= brightness + 8'd5;
            else
                brightness <= brightness - 8'd5;

            if (brightness >= 8'd250) direction <= 1'b0;
            else if (brightness <= 8'd5) direction <= 1'b1;
        end
    end

    // PWM logic to all 3 LEDs
    always @(posedge clk) begin
        if (pwm_counter < brightness) begin
            led1 <= 1;
            led2 <= 1;
            led3 <= 1;
        end else begin
            led1 <= 0;
            led2 <= 0;
            led3 <= 0;
        end
    end

endmodule
