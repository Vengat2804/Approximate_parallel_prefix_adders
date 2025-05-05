module test_adder_tb;

    integer infile, ks_exact_outfile, ks_approx_outfile, lf_exact_outfile, lf_approx_outfile;
    integer i;
    reg [7:0] A, B;            
    wire [8:0] SUM_KS_EXACT;  
    wire [8:0] SUM_KS_APPROX;  
    wire [8:0] SUM_LF_EXACT;   
    wire [8:0] SUM_LF_APPROX;  

    // Instantiate the modules
    kogge_stone_8bit ks_exact (.A(A), .B(B), .SUM(SUM_KS_EXACT));
    kogge_stone_approx ks_approx (.A(A), .B(B), .SUM(SUM_KS_APPROX));
    ladner_fischer_8bit lf_exact (.A(A), .B(B), .SUM(SUM_LF_EXACT));
    ladner_fischer_approx lf_approx (.A(A), .B(B), .SUM(SUM_LF_APPROX));

    initial begin
        infile = $fopen("D:/project/matlab/input_vectors.txt", "r");
        ks_exact_outfile = $fopen("D:/project/simulation/ks_exact_outputs.txt", "w");
        ks_approx_outfile = $fopen("D:/project/simulation/ks_approx_outputs.txt", "w");
        lf_exact_outfile = $fopen("D:/project/simulation/lf_exact_outputs.txt", "w");
        lf_approx_outfile = $fopen("D:/project/simulation/lf_approx_outputs.txt", "w");

        if (infile == 0 || ks_exact_outfile == 0 || ks_approx_outfile == 0 ||
            lf_exact_outfile == 0 || lf_approx_outfile == 0) begin
            $display("Error: Unable to open one or more files!");
            $finish;
        end
        while (!$feof(infile)) begin
            i = $fscanf(infile, "%d %d\n", A, B); 
            if (i != 2) begin
                $display("Error: Invalid input format!");
                $finish;
            end
            #10;
            $fwrite(ks_exact_outfile, "%d\n", SUM_KS_EXACT);
            $fwrite(ks_approx_outfile, "%d\n", SUM_KS_APPROX);
            $fwrite(lf_exact_outfile, "%d\n", SUM_LF_EXACT);
            $fwrite(lf_approx_outfile, "%d\n", SUM_LF_APPROX);
        end
        $fclose(infile);
        $fclose(ks_exact_outfile);
        $fclose(ks_approx_outfile);
        $fclose(lf_exact_outfile);
        $fclose(lf_approx_outfile);

        $display("Testbench execution complete. Output files generated successfully.");
        $finish;
    end

endmodule