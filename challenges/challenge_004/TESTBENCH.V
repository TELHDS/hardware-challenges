`timescale 1ns / 1ps

module tb_adder_8bit;
    // Inputs
    reg [7:0] a;
    reg [7:0] b;
    reg cin;
    
    // Outputs
    wire [7:0] sum;
    wire cout;
    
    // Expected outputs for verification
    reg [8:0] expected_result;
    
    // Test statistics
    integer test_count = 0;
    integer pass_count = 0;
    integer fail_count = 0;
    
    // Instantiate the Unit Under Test (UUT)
    adder_8bit uut (
        .a(a),
        .b(b),
        .cin(cin),
        .sum(sum),
        .cout(cout)
    );
    
    // Test procedure
    initial begin
        $display("=== 8-bit Ripple Carry Adder Testbench ===");
        $display("Time\t\tA\t\tB\t\tCin\tSum\t\tCout\tExpected\tResult");
        $display("-------------------------------------------------------------------------------------");
        
        // Test Case 1: All zeros
        test_case(8'h00, 8'h00, 1'b0, "All zeros");
        
        // Test Case 2: Simple addition
        test_case(8'h0F, 8'h11, 1'b0, "15 + 17");
        
        // Test Case 3: Maximum values
        test_case(8'hFF, 8'hFF, 1'b0, "255 + 255");
        
        // Test Case 4: Maximum with carry
        test_case(8'hFF, 8'hFF, 1'b1, "255 + 255 + 1");
        
        // Test Case 5: Carry propagation
        test_case(8'h7F, 8'h01, 1'b0, "127 + 1");
        
        // Test Case 6: No carry
        test_case(8'h55, 8'h2A, 1'b0, "85 + 42");
        
        // Test Case 7: Alternating pattern
        test_case(8'hAA, 8'h55, 1'b0, "170 + 85");
        
        // Test Case 8: Single bit set
        test_case(8'h80, 8'h80, 1'b0, "128 + 128");
        
        // Test Case 9: Carry from previous
        test_case(8'h00, 8'h00, 1'b1, "0 + 0 + 1");
        
        // Test Case 10: Random comprehensive test
        repeat(20) begin
            a = $random;
            b = $random;
            cin = $random;
            test_case(a, b, cin, "Random test");
        end
        
        // Final results
        $display("-------------------------------------------------------------------------------------");
        $display("Test Summary:");
        $display("Total Tests: %d", test_count);
        $display("Passed: %d", pass_count);
        $display("Failed: %d", fail_count);
        $display("Success Rate: %0.1f%%", (pass_count * 100.0) / test_count);
        
        if (fail_count == 0) begin
            $display("🎉 ALL TESTS PASSED! Design is functionally correct.");
        end else begin
            $display("❌ Some tests failed. Please check your implementation.");
        end
        
        $finish;
    end
    
    // Task to run individual test cases
    task test_case(input [7:0] test_a, input [7:0] test_b, input test_cin, input [200:0] description);
        begin
            a = test_a;
            b = test_b;
            cin = test_cin;
            
            #1; // Wait for propagation
            
            expected_result = test_a + test_b + test_cin;
            test_count = test_count + 1;
            
            $write("%0t\t\t%h\t\t%h\t\t%b\t%h\t\t%b\t%h\t\t", 
                   $time, a, b, cin, sum, cout, expected_result);
            
            if ({cout, sum} == expected_result) begin
                $display("PASS\t%s", description);
                pass_count = pass_count + 1;
            end else begin
                $display("FAIL\t%s", description);
                fail_count = fail_count + 1;
                $display("         Expected: %h, Got: %h", expected_result, {cout, sum});
            end
            
            #1; // Small delay between tests
        end
    endtask

endmodule
