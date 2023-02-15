%IEEE TCAS ii
%ACCEPTED: "Utilization of Contingency Tables in Stochastic Computing"
% Res. Asst. & PhD. Cand. Sercan AYGUN & Prof. Dr. Ece Olcay GUNES
% Istanbul Technical University
% for further info: ayguns@itu.edu.tr
close all 
clear all
%For memory calculations please refer to:
%https://www.mathworks.com/matlabcentral/answers/97560-how-can-i-monitor-how-much-memory-matlab-is-using
N = 8; 

memo = 0;  %comment this for timing test
%timing = 0; %comment this for memory test
iterator = 0; %comment this for timing test
test_iteration = 1; 

for j = 1:1:test_iteration
tic
for X1 = 0:1:N
    for X2 = 0:1:N
        amin = max(0,X1+X2-N);
        amax = min(X1, X2);
        for a = amin:1:amax
            b = (X1 - a);
            c = (X2 - a);
            d = (N - a - b - c);
            result = a; %AND operation. Any other TCO-based logic operations may be applied
            iterator = iterator + 1; %comment this for timing test
            memo = memo + monitor_memory_whos; %comment this for timing test
        end
    end
end
%elapsed_time_CT = toc; %comment this for memory test
%timing = timing + elapsed_time_CT; %comment this for memory test
end

%time_CT = timing / test_iteration %comment this for memory test
mem_CT = memo/iterator %comment this for timing test