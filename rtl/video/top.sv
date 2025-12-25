module top(input logic clk,
           input logic [3:0] btn, 
           input logic [15:0] sw, 
           output logic hdmi_clk_p, 
           output logic hdmi_clk_n, 
           output logic [2:0] hdmi_tx_n, 
           output logic [2:0] hdmi_tx_p);
        
        logic pattern_sel;
        assign pattern_sel = sw[0];

        logic reset;
        assign reset = btn[0];

        logic pxl_clk;
        logic pxl_clkx5;
        logic locked;
        logic hsync;
        logic vsync;
        logic vde;
        logic [9:0] x;
        logic [9:0] y;
        logic [7:0] base_red;
        logic [7:0] base_green;
        logic [7:0] base_blue;
        logic [7:0] red;
        logic [7:0] green;
        logic [7:0] blue;


        clk_wiz_0 clock_wizard(.clk_in1(clk), 
                               .reset(reset), 
                               .pxl_clk(pxl_clk), 
                               .pxl_clkx5(pxl_clkx5), 
                               .locked(locked)
                               );
        
        video_timing VGA(.reset(reset),
                         .clk(pxl_clk), 
                         .hsync(hsync), 
                         .vsync(vsync), 
                         .vde(vde), 
                         .x(x), 
                         .y(y)
                         );

        test_patterns test(.x(x), 
                           .y(y), 
                           .vde(vde), 
                           .pattern_sel(pattern_sel), 
                           .red(base_red), 
                           .green(base_green), 
                           .blue(base_blue)
                           );
        overlay overlay_layer(.x(x), 
                        .y(y), 
                        .vde(vde), 
                        .base_red(base_red), 
                        .base_green(base_green), 
                        .base_blue(base_blue), 
                        .red(red), 
                        .green(green), 
                        .blue(blue)
                        );

        hdmi_tx_0 VGA_to_HDMI(.pix_clk(pxl_clk), 
                              .pix_clkx5(pxl_clkx5), 
                              .pix_clk_locked(locked), 
                              .rst(reset), 
                              .red(red), 
                              .green(green), 
                              .blue(blue), 
                              .hsync(hsync), 
                              .vsync(vsync), 
                              .vde(vde), 
                              .aux0_din(4'b0), 
                              .aux1_din(4'b0), 
                              .aux2_din(4'b0), 
                              .ade(1'b0), 
                              .TMDS_CLK_P(hdmi_clk_p), 
                              .TMDS_CLK_N(hdmi_clk_n), 
                              .TMDS_DATA_P(hdmi_tx_p), 
                              .TMDS_DATA_N(hdmi_tx_n)
                              );

endmodule
