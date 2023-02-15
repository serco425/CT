%IEEE TCAS ii
%UNDER REVIEW: "Utilization of Contingency Tables in Stochastic Computing"
% Res. Asst. & PhD. Cand. Sercan AYGUN & Prof. Dr. Ece Olcay GUNES
% Istanbul Technical University
% for further info: ayguns@itu.edu.tr

%USER INTERFACE MAIN

arithmetic = input("Please enter a number for SC-based arithmetic \n 1 Saturating Adder \n 2 Subtractor \n 3 Multiplier \n 4 Scaled Adder \n 5 Three-Input Multiplier \n 6 Mixed Correlation Example \n or 7 Run the CT-based vs. Bitstream-based ALL BITSTREAM COMBINATIONS \n");
if arithmetic ~= 1 && arithmetic ~= 2 && arithmetic ~= 3 && arithmetic ~= 4 && arithmetic ~= 5 && arithmetic ~= 6 && arithmetic ~= 7
    error('Wrong operation choice. Run the code again!') 
end

N = input("Please enter N as 8 or 16 or 32 or 64 or 128 or 256 or 512 or 1024 \n");
if N ~= 8 && N ~= 16 && N ~= 32 && N ~= 64 && N ~= 128 && N ~= 256 && N ~= 512 && N ~= 1024
    error('Wrong stream size selection. Run the code again!') 
end

if arithmetic == 1
    SATURATING_ADDER(N);
end
if arithmetic == 2
    SUBTRACTOR(N);
end
if arithmetic == 3
    MULTIPLIER(N);
end
if arithmetic == 4
    SCALED_ADDER(N);
end
if arithmetic == 5
    THREE_INPUT_MULTIPLIER(N);
end
if arithmetic == 6
    MIXED_EXAMPLE(N);
end
if arithmetic == 7
    all_combinations_timing_CT_versus_bitstream(N);
end

        