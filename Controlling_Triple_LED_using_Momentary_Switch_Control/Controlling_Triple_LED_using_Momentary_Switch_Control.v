module button_led (
    input clk,
    input button1,  // Active-low: 0 = pressed
    input button2,
    input button3,
    output reg led1,
    output reg led2,
    output reg led3
);

always @(posedge clk) begin
    led1 <= ~button1;  // LED ON when pressed
    led2 <= ~button2;
    led3 <= ~button3;
end

endmodule

