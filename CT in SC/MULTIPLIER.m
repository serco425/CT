function MULTIPLIER(N)
%IEEE TCAS ii
%UNDER REVIEW: "Utilization of Contingency Tables in Stochastic Computing"
% Res. Asst. & PhD. Cand. Sercan AYGUN & Prof. Dr. Ece Olcay GUNES
% Istanbul Technical University
% for further info: ayguns@itu.edu.tr

%UNCORRELATED
%   _  _  _|   _  _ _|_ _
%  (_|| |(_|  (_|(_| | (/_
%              _|

%CT.m is required and it returns any of the correlation approach:
%[a_mid(i), a_poly(i), a_best(i), a_min(i), a_max(i)] = CT(X1, X2, N);

%YOU MAY ONLY CHANGE N
%N = 8; %stream size; parametric, N-> 8, 16, 32, 64, 128, 256, 512, 1024

i = 1; %for iteration

%Cartesian product of X1, X2, which represent 1's in a stream.
%Division by N is the related probability
for X1 = 0:1:N
    for X2 = 0:1:N
        multiplier(i) = (X1/N)*(X2/N); %Expected SC-based arithmetic
        %Division by N is the related probability
        %P_out = P_X1 * P_X2
        
        [a_mid(i), a_poly(i), a_best(i), ~, ~] = CT(X1, X2, N);
        
        %CT AND -> TCO = a
        %No need the rest of the CT primitives
        
        i = i + 1; %for counting iteration
    end
end

%parameters for total error
MUL_amid = 0;
MUL_apoly = 0;
MUL_abest = 0;

for j = 1:1:(i-1)
    
    %uncorrelated model -> a_mid or a_poly or a_best & AND model TCO = a [CT in SC Logic]
    %'absolute error'
    MUL_amid = MUL_amid + abs(multiplier(j) - (a_mid(j)/N));
    MUL_apoly = MUL_apoly + abs(multiplier(j) - (a_poly(j)/N));
    MUL_abest = MUL_abest + abs(multiplier(j) - (a_best(j)/N));
    
end

format long

%Mean of 'absolute error'
MAE_MUL_amid = MUL_amid / ((N+1)*(N+1))
MAE_MUL_apoly = MUL_apoly / ((N+1)*(N+1))
MAE_MUL_abest = MUL_abest / ((N+1)*(N+1))

