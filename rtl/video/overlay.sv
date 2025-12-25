module overlay(input logic [9:0] x, 
               input logic [9:0] y, 
               input logic vde,
               input logic [7:0] base_red,
               input logic [7:0] base_green,
               input logic [7:0] base_blue,
               output logic [7:0] red, 
               output logic [7:0] green, 
               output logic [7:0] blue
               );
    
    always_comb begin
        red = base_red;
        blue = base_blue;
        green = base_green;
        if(!vde) begin
            red = 8'h00;
            green = 8'h00;
            blue = 8'h00;
        end
        else if ((x < 120) && (y < 60)) begin
            red = 8'h00;
            green = 8'hFF;
            blue = 8'h00;
        end
    end



endmodule
