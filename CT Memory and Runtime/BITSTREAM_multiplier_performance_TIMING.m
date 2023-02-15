%IEEE TCAS ii
%ACCEPTED: "Utilization of Contingency Tables in Stochastic Computing"
% Res. Asst. & PhD. Cand. Sercan AYGUN & Prof. Dr. Ece Olcay GUNES
% Istanbul Technical University
% for further info: ayguns@itu.edu.tr
clear all
close all
%For memory calculations please refer to:
%https://www.mathworks.com/matlabcentral/answers/97560-how-can-i-monitor-how-much-memory-matlab-is-using
N = 8; 
 
%memo = 0;  %comment this for timing test
timing = 0; %comment this for memory test
%iterator = 0; %comment this for timing test
test_iteration = 1; 
 
for i = 1:1:test_iteration
tic
for X1 = 0:1:N
    bit_occurrence_X1_total = factorial(N)/(factorial(N-X1)*factorial(X1));
    
    if X1 == 0
        X1_comb = zeros(1, N);
    else
        X1_comb = dec2bin(sum(nchoosek(2.^(0:N-1),X1),2)) - '0'; %https://www.mathworks.com/matlabcentral/answers/510687-produce-all-combinations-of-n-choose-k-in-binary
    end   
    
    for X2 = 0:1:N
        bit_occurrence_X2_total = factorial(N)/(factorial(N-X2)*factorial(X2));
        
        if X2 == 0
            X2_comb = zeros(1, N);
        else
            X2_comb = dec2bin(sum(nchoosek(2.^(0:N-1),X2),2)) - '0';
        end
        
        for bit_occurrence_X1 = 1:1:bit_occurrence_X1_total
            
            for bit_occurrence_X2 = 1:1:bit_occurrence_X2_total
                output_stream = and(X1_comb(bit_occurrence_X1, :), X2_comb(bit_occurrence_X2, :));           
                %result = sum(output_stream)/N;  
                %iterator = iterator + 1; %comment this for timing test
                %memo = memo + monitor_memory_whos; %comment this for timing test
            end
        end
    end
end
elapsed_time_CT = toc; %comment this for memory test
timing = timing + elapsed_time_CT; %comment this for memory test
end
 
time_BS = timing / test_iteration %comment this for memory test
%mem_BS = memo/iterator %comment this for timing test
