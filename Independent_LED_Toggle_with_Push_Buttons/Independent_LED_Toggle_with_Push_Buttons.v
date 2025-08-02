module button_led_toggle (
    input clk,             // System clock
    input button1,         // Active-low button inputs
    input button2,
    input button3,
    output reg led1,       // LED outputs
    output reg led2,
    output reg led3
);

// Internal signals for edge detection
reg button1_prev = 1;  // Initial state HIGH due to pull-up
reg button2_prev = 1;
reg button3_prev = 1;

always @(posedge clk) begin
    // Detect falling edge (HIGH to LOW due to pull-up resistor)
    if (button1_prev == 1 && button1 == 0)
        led1 <= ~led1;
    if (button2_prev == 1 && button2 == 0)
        led2 <= ~led2;
    if (button3_prev == 1 && button3 == 0)
        led3 <= ~led3;

    // Update previous states
    button1_prev <= button1;
    button2_prev <= button2;
    button3_prev <= button3;
end

endmodule
