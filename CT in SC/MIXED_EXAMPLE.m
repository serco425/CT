function MIXED_EXAMPLE(N)
%IEEE TCAS ii
%UNDER REVIEW: "Utilization of Contingency Tables in Stochastic Computing"
% Res. Asst. & PhD. Cand. Sercan AYGUN & Prof. Dr. Ece Olcay GUNES
% Istanbul Technical University
% for further info: ayguns@itu.edu.tr

%   _ _ .   _  _|   _    _  _ _  _ | _
%  | | ||><(/_(_|  (/_><(_|| | ||_)|(/_
%                               |                                 

%CT.m is required and it returns any of the correlation approach:
%[a_mid(i), a_poly(i), a_best(i), a_min(i), a_max(i)] = CT(X1, X2, N);

%YOU MAY ONLY CHANGE N
%N = 512; %stream size; parametric, N-> 8, 16, 32, 64, 128, 256, 512, 1024

i = 1; %for iteration

%Cartesian product of X1, X2, X3, which represent 1's in a stream.
for X1 = 0:1:N
    for X2 = 0:1:N
        for X3 = 0:1:N
            func(i) = abs(((X1/N)*(X2/N))-(X3/N)); %Expected SC-based arithmetic
            %Division by N is the related probability
            %P_out = |(P_X1 * P_X2) - (P_X3)|
            
            %For AND(X1, X2) CT1
            %CT1 AND -> TCO = a_CT1
            [a_CT1_amid, a_CT1_apoly, a_CT1_abest, ~, ~] = CT(X1, X2, N);
            %CT1 is uncorrelated by either a_mid or a_poly or a_best
            
            %CT2 gets results from CT1 (cascading)
            %CT2(a_CT1, X3) -> XOR is important as final stage
            %CT2 XOR -> TCO = b_CT2 + c_CT2
            %CT2 is maximally correlated (a_max)
            [~, ~, ~, ~, amax_CT2_CT1mid] = CT(a_CT1_amid, X3, N);
            [~, ~, ~, ~, amax_CT2_CT1poly] = CT(a_CT1_apoly, X3, N);
            [~, ~, ~, ~, amax_CT2_CT1best] = CT(a_CT1_abest, X3, N);
            
            %FOR MEMORY, only b & c are assigned based on the i index,
            %a.k.a all possibilities
            %The only crucial CT primitives b, c for XOR
            %b = first_operand - a;
            %c = second_operand - a;
            % finding b & c of CT2
            b_CT2_CT1mid(i) = a_CT1_amid - amax_CT2_CT1mid; %CT1 is with amid
            c_CT2_CT1mid(i) = X3 - amax_CT2_CT1mid;
            
            b_CT2_CT1poly(i) = a_CT1_apoly - amax_CT2_CT1poly; %CT1 is with apoly
            c_CT2_CT1poly(i) = X3 - amax_CT2_CT1poly;
            
            b_CT2_CT1best(i) = a_CT1_abest - amax_CT2_CT1best; %CT1 is with abest
            c_CT2_CT1best(i) = X3 - amax_CT2_CT1best;
            
            i = i + 1; %for counting iteration
        end
    end
end

%parameters for total error
FUNC_CT1_amid = 0;
FUNC_CT1_apoly = 0;
FUNC_CT1_abest = 0;

for j = 1:1:(i-1)
    
    %TCO = b + c -> CT2 XOR gate [CT in SC Logic]
    %'absolute error'
    FUNC_CT1_amid = FUNC_CT1_amid + abs(func(j) - ((b_CT2_CT1mid(j) + c_CT2_CT1mid(j))/N));
    FUNC_CT1_apoly = FUNC_CT1_apoly + abs(func(j) - ((b_CT2_CT1poly(j) + c_CT2_CT1poly(j))/N));
    FUNC_CT1_abest = FUNC_CT1_abest + abs(func(j) - ((b_CT2_CT1best(j) + c_CT2_CT1best(j))/N));
end

format long

%Mean of 'absolute error'
MAE_FUNC_CT1_amid = FUNC_CT1_amid / ((N+1)*(N+1)*(N+1))
MAE_FUNC_CT1_apoly = FUNC_CT1_apoly / ((N+1)*(N+1)*(N+1))
MAE_FUNC_CT1_abest = FUNC_CT1_abest / ((N+1)*(N+1)*(N+1))

end