// legacy implementation of non overlapping moore sequence detector for 1010
module sqdmo1010no (
    input  bit clk,
    input  bit rst_n,
    input  bit x,
    output reg z
);
  parameter A = 4'h1;
  parameter B = 4'h2;
  parameter C = 4'h3;
  parameter D = 4'h4;
  parameter E = 4'h5;
  // extra state when compared with mealy machine

  bit [3:0] state, next_state;

  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      state <= A;
    end else state <= next_state;
  end

  always @(state or x) begin
    case (state)
      A: begin
        if (x == 0) next_state = A;
        else next_state = B;
      end
      B: begin
        if (x == 0) next_state = C;
        else next_state = B;
      end
      C: begin
        if (x == 0) next_state = A;
        else next_state = D;
      end
      D: begin
        if (x == 0) next_state = E;
        else next_state = B;
      end
      E: begin
        if (x == 0) next_state = A;
        else next_state = B;
        //this state only differs when compared with moore overlaping machine
      end
      default: next_state = A;
    endcase
  end

  //as output z is only depends on present state
  always @(state) begin
    case (state)
      A: z = 0;
      B: z = 0;
      C: z = 0;
      D: z = 0;
      E: z = 1;
      default: z = 0;
    endcase
  end

endmodule
