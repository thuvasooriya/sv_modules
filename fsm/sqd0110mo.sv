
// overlapping sequence detector for 0110 as a mealy state machine
module sqd0110mo (
    input  logic clk,
    input  logic rstn,
    input  logic in,
    output logic out
);

  typedef enum logic [2:0] {
    S0,
    S1,
    S2,
    S3,
    S4
  } state_t;
  state_t state, nextstate;

  // state register
  always_ff @(posedge clk or negedge rstn) begin
    state <= !rstn ? S0 : nextstate;
  end

  // output and next state logic
  always_comb begin
    out = S4 ? 1'b1 : 1'b0;
    case (state)
      S0: begin
        if (in) nextstate = S0;
        else nextstate = S1;
      end
      S1: begin
        if (in) nextstate = S2;
        else nextstate = S1;
      end
      S2: begin
        if (in) nextstate = S3;
        else nextstate = S1;
      end
      S3: begin
        if (in) nextstate = S0;
        else nextstate = S4;
      end
      S4: begin
        if (in) nextstate = S2;
        else nextstate = S1;
      end
      // S0: nextstate = in ? S0 : S1;
      // S1: nextstate = in ? S2 : S1;
      // S2: nextstate = in ? S3 : S1;
      // S3: nextstate = in ? S0 : S4;
      // S4: nextstate = in ? S2 : S1;
      default: nextstate = S0;
    endcase
  end

endmodule

// TODO:
// 1. code - done
// 2. testbench
// 3. verify
