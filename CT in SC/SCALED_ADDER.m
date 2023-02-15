function SCALED_ADDER(N)
%IEEE TCAS ii
%UNDER REVIEW: "Utilization of Contingency Tables in Stochastic Computing"
% Res. Asst. & PhD. Cand. Sercan AYGUN & Prof. Dr. Ece Olcay GUNES
% Istanbul Technical University
% for further info: ayguns@itu.edu.tr

%  |\/|| |\/ 
%  |  ||_|/\  
%

%CT.m is required and it returns any of the correlation approach:
%[a_mid(i), a_poly(i), a_best(i), a_min(i), a_max(i)] = CT(X1, X2, N);

%YOU MAY ONLY CHANGE N
%N = 8; %stream size; parametric, N-> 8, 16, 32, 64, 128, 256, 512, 1024


%----------------------------------a_mid-----------------------------------
i = 1; %for iteration

%Cartesian product of X1, X2, which represent 1's in a stream.
%Division by N is the related probability
for X1 = 0:1:N
    for X2 = 0:1:N
        scaled_adder(i) = ((X1/N)+(X2/N))/2; %Expected SC-based arithmetic
        %Division by N is the related probability
        %P_out = (P_X1 + P_X2) / 2
        %P_S = 1/2 -> selection probability
        
        [a_CT1, ~, ~, ~, ~] = CT(X1, (N/2), N); %For AND(X1, S=N/2) CT1
        [a_CT2, ~, ~, ~, ~] = CT(X2, (N/2), N); %For AND(X2, ~S=N/2) CT2
        
        %CT1 AND -> TCO = a_CT1
        %CT2 AND -> TCO = a_CT2
        
        %CT3 gets results from CT1 and CT2 (cascading)
        %CT3(a_CT1, a_CT2) -> OR is important as final stage
        %CT3 OR -> TCO = a_CT3 + b_CT3 + c_CT3
        [~, ~, ~, a_CT3(i), ~] = CT(a_CT1, a_CT2, N);
        
        b_CT3(i) = a_CT1 - a_CT3(i); %b = first_operand - a;
        c_CT3(i) = a_CT2 - a_CT3(i); %c = second_operand - a;
        %d_CT3(i) = N - (a_CT3(i) + b_CT3(i) + c_CT3(i)); %d = N - (a+b+c);
        %We do not need 'd' for this scaled adder, i.e., MUX example
        
        i = i + 1; %for counting iteration
    end
end

SCALED_ADD = 0; %a parameter for total error

for j = 1:1:(i-1)
    
    %'absolute error'
    SCALED_ADD = SCALED_ADD + abs(scaled_adder(j) - ((a_CT3(j) + b_CT3(j) + c_CT3(j))/N));
    
end

format long

MAE_MUX_amid = SCALED_ADD / ((N+1)*(N+1))

clearvars -except N

%----------------------------------a_poly----------------------------------
i = 1; %for iteration

%Cartesian product of X1, X2, which represent 1's in a stream.
%Division by N is the related probability
for X1 = 0:1:N
    for X2 = 0:1:N
        scaled_adder(i) = ((X1/N)+(X2/N))/2; %Expected SC-based arithmetic
        %Division by N is the related probability
        %P_out = (P_X1 + P_X2) / 2
        %P_S = 1/2 -> selection probability
        
        [~, a_CT1, ~, ~, ~] = CT(X1, (N/2), N); %For AND(X1, S=N/2) CT1
        [~, a_CT2, ~, ~, ~] = CT(X2, (N/2), N); %For AND(X2, ~S=N/2) CT2
        
        %CT1 AND -> TCO = a_CT1
        %CT2 AND -> TCO = a_CT2
        
        %CT3 gets results from CT1 and CT2 (cascading)
        %CT3(a_CT1, a_CT2) -> OR is important as final stage
        %CT3 OR -> TCO = a_CT3 + b_CT3 + c_CT3
        [~, ~, ~, a_CT3(i), ~] = CT(a_CT1, a_CT2, N);
        
        b_CT3(i) = a_CT1 - a_CT3(i); %b = first_operand - a;
        c_CT3(i) = a_CT2 - a_CT3(i); %c = second_operand - a;
        %d_CT3(i) = N - (a_CT3(i) + b_CT3(i) + c_CT3(i)); %d = N - (a+b+c);
        %We do not need 'd' for this scaled adder, i.e., MUX example
        
        i = i + 1; %for counting iteration
    end
end

SCALED_ADD = 0; %a parameter for total error

for j = 1:1:(i-1)
    
    %'absolute error'
    SCALED_ADD = SCALED_ADD + abs(scaled_adder(j) - ((a_CT3(j) + b_CT3(j) + c_CT3(j))/N));
    
end

format long

MAE_MUX_apoly = SCALED_ADD / ((N+1)*(N+1))

clearvars -except N

%----------------------------------a_best----------------------------------
i = 1; %for iteration

%Cartesian product of X1, X2, which represent 1's in a stream.
%Division by N is the related probability
for X1 = 0:1:N
    for X2 = 0:1:N
        scaled_adder(i) = ((X1/N)+(X2/N))/2; %Expected SC-based arithmetic
        %Division by N is the related probability
        %P_out = (P_X1 + P_X2) / 2
        %P_S = 1/2 -> selection probability
        
        [~, ~, a_CT1, ~, ~] = CT(X1, (N/2), N); %For AND(X1, S=N/2) CT1
        [~, ~, a_CT2, ~, ~] = CT(X2, (N/2), N); %For AND(X2, ~S=N/2) CT2
        
        %CT1 AND -> TCO = a_CT1
        %CT2 AND -> TCO = a_CT2
        
        %CT3 gets results from CT1 and CT2 (cascading)
        %CT3(a_CT1, a_CT2) -> OR is important as final stage
        %CT3 OR -> TCO = a_CT3 + b_CT3 + c_CT3
        [~, ~, ~, a_CT3(i), ~] = CT(a_CT1, a_CT2, N);
        
        b_CT3(i) = a_CT1 - a_CT3(i); %b = first_operand - a;
        c_CT3(i) = a_CT2 - a_CT3(i); %c = second_operand - a;
        %d_CT3(i) = N - (a_CT3(i) + b_CT3(i) + c_CT3(i)); %d = N - (a+b+c);
        %We do not need 'd' for this scaled adder, i.e., MUX example
        
        i = i + 1; %for counting iteration
    end
end

SCALED_ADD = 0; %a parameter for total error

for j = 1:1:(i-1)
    
    %'absolute error'
    SCALED_ADD = SCALED_ADD + abs(scaled_adder(j) - ((a_CT3(j) + b_CT3(j) + c_CT3(j))/N));
    
end

format long

MAE_MUX_abest = SCALED_ADD / ((N+1)*(N+1))

end