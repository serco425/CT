function THREE_INPUT_MULTIPLIER(N)
%IEEE TCAS ii
%UNDER REVIEW: "Utilization of Contingency Tables in Stochastic Computing"
% Res. Asst. & PhD. Cand. Sercan AYGUN & Prof. Dr. Ece Olcay GUNES
% Istanbul Technical University
% for further info: ayguns@itu.edu.tr

%  _|_|_  _ _  _   __  . _  _   _|_   _ _    |_|_. _ |. _  _
%   | | || (/_(/_      || ||_)|_||   | | ||_|| | ||_)||(/_|
%                          |                      |

%CT.m is required and it returns any of the correlation approach:
%[a_mid(i), a_poly(i), a_best(i), a_min(i), a_max(i)] = CT(X1, X2, N);

%YOU MAY ONLY CHANGE N
%N = 256; %stream size; parametric, N-> 8, 16, 32, 64, 128, 256, 512, 1024

i = 1; %for iteration

%Cartesian product of X1, X2, X3, which represent 1's in a stream.
for X1 = 0:1:N
    for X2 = 0:1:N
        for X3 = 0:1:N
            multiplier(i) = (X1/N)*(X2/N)*(X3/N); %Expected SC-based arithmetic
            %Division by N is the related probability
            %P_out = P_X1 * P_X2 * P_X3
            
            %For AND(X1, X2) CT1
            %AND -> TCO = a_CT1
            [a_CT1_amid, a_CT1_apoly, a_CT1_abest, ~, ~] = CT(X1, X2, N);
            
            %For AND(X3, (X1*X2)) CT2
            %AND -> TCO = a_CT2 (second AND)
            [a_CT2_amid(i), ~, ~, ~, ~] = CT(X3, a_CT1_amid, N); %a_mid
            [~, a_CT2_apoly(i), ~, ~, ~] = CT(X3, a_CT1_apoly, N); %a_poly
            [~, ~, a_CT2_abest(i), ~, ~] = CT(X3, a_CT1_abest, N); %a_best
            
            %No need the rest of the CT primitives
            
            i = i + 1; %for counting iteration
        end
    end
end

%parameters for total error
THREE_IN_MULTIPLIER_amid = 0;
THREE_IN_MULTIPLIER_apoly = 0;
THREE_IN_MULTIPLIER_abest = 0;

for j = 1:1:(i-1)
    
    %uncorrelated model -> a_mid or a_poly or a_best & AND model TCO = a [CT in SC Logic]
    %'absolute error'
    THREE_IN_MULTIPLIER_amid = THREE_IN_MULTIPLIER_amid + abs(multiplier(j) - ((a_CT2_amid(j))/N));
    THREE_IN_MULTIPLIER_apoly = THREE_IN_MULTIPLIER_apoly + abs(multiplier(j) - ((a_CT2_apoly(j))/N));
    THREE_IN_MULTIPLIER_abest = THREE_IN_MULTIPLIER_abest + abs(multiplier(j) - ((a_CT2_abest(j))/N));
end

format long

MAE_MUL_3_amid = THREE_IN_MULTIPLIER_amid / ((N+1)*(N+1)*(N+1))
MAE_MUL_3_apoly = THREE_IN_MULTIPLIER_apoly / ((N+1)*(N+1)*(N+1))
MAE_MUL_3_abest = THREE_IN_MULTIPLIER_abest / ((N+1)*(N+1)*(N+1))

end