function SUBTRACTOR(N)
%IEEE TCAS ii
%UNDER REVIEW: "Utilization of Contingency Tables in Stochastic Computing"
% Res. Asst. & PhD. Cand. Sercan AYGUN & Prof. Dr. Ece Olcay GUNES
% Istanbul Technical University
% for further info: ayguns@itu.edu.tr

%POSITIVELY CORR.
%     _  _   _  _ _|_ _
%  ><(_)|   (_|(_| | (/_
%            _|

%CT.m is required and it returns any of the correlation approach:
%[a_mid(i), a_poly(i), a_best(i), a_min(i), a_max(i)] = CT(X1, X2, N);

%YOU MAY ONLY CHANGE N
%N = 8; %stream size; parametric, N-> 8, 16, 32, 64, 128, 256, 512, 1024

i = 1; %for iteration

%Cartesian product of X1, X2, which represent 1's in a stream.
%Division by N is the related probability
for X1 = 0:1:N
    for X2 = 0:1:N
        subtractor(i) = abs((X1/N)-(X2/N)); %Expected SC-based arithmetic
        %Division by N is the related probability
        %P_out = |P_X1-P_X2|
        
        [~, ~, ~, ~, a_max(i)] = CT(X1, X2, N);
        
        %CT XOR -> TCO = b + c
        
        %The rest of the CT primitives (Fig. 2 in the revised manuscript)
        b(i) = X1 - a_max(i);
        c(i) = X2 - a_max(i);
        %d(i) = N - (a_max(i) + b(i) + c(i));
        %We do not need 'd' for this subtractor, i.e., XOR example
        
        i = i + 1; %for counting iteration
    end
end

SUB = 0; %a parameter for total error

for j = 1:1:(i-1)
    
    %positively correlated model -> amax & XOR model TCO = b + c [CT in SC Logic]
    %'absolute error'
    SUB = SUB + abs(subtractor(j) - ((b(j) + c(j))/N));
    
end

format long

%Mean of 'absolute error'
MAE_SUB = SUB / ((N+1)*(N+1))

end
