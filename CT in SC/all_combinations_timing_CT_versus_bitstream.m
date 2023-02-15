function all_combinations_timing_CT_versus_bitstream(N)
%IEEE TCAS ii
%UNDER REVIEW: "Utilization of Contingency Tables in Stochastic Computing"
% Res. Asst. & PhD. Cand. Sercan AYGUN & Prof. Dr. Ece Olcay GUNES
% Istanbul Technical University
% for further info: ayguns@itu.edu.tr

%   _ ||   _ _  _ _ |_ . _  _ _|_. _  _  _
%  (_|||  (_(_)| | ||_)|| |(_| | |(_)| |_\

%CT.m is required and it returns any of the correlation approach:
%[a_mid(i), a_poly(i), a_best(i), a_min(i), a_max(i)] = CT(X1, X2, N);

%YOU MAY ONLY CHANGE N
%N = 8; %stream size; parametric, N-> 8, 16, 32, 64, 128, 256, 512, 1024

format long

unique_CTs = 0; %# of total unique CT
tic;
for X1 = 0:1:N
    for X2 = 0:1:N
        amin = max(0,X1+X2-N);
        amax = min (X1, X2);
        for a = amin:1:amax
            b = (X1 - a);
            c = (X2 - a);
            d = (N - a - b - c);
            %... Any operation like TCO calculation (i.e. logic operation)
            unique_CTs = unique_CTs + 1; 
        end
    end
end
elapsed_time_CT = toc

binary_pairs = 0; %# of total binary pair combinations
tic
for X1 = 0:1:N
    for X2 = 0:1:N
        
        bit_occurrence_X1_total = factorial(N)/(factorial(N-X1)*factorial(X1));
        for bit_occurrence_X1 = 1:1:bit_occurrence_X1_total
            
            bit_occurrence_X2_total = factorial(N)/(factorial(N-X2)*factorial(X2));
            for bit_occurrence_X2 = 1:1:bit_occurrence_X2_total
               %... Any operation like bit-by-bit logic processing
                binary_pairs = binary_pairs + 1; 
            end
        end
    end
end

elapsed_time_bitstream = toc

end