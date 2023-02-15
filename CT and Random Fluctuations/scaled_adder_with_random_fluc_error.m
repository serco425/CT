%IEEE TCAS ii
%UNDER 2nd REVIEW: "Utilization of Contingency Tables in Stochastic Computing"
% Res. Asst. & PhD. Cand. Sercan AYGUN & Prof. Dr. Ece Olcay GUNES
% Istanbul Technical University
% for further info: ayguns@itu.edu.tr

%CT.m is required and it returns any of the correlation approach:
%[a_mid(i), a_poly(i), a_best(i), a_min(i), a_max(i)] = CT(X1, X2, N);

clear all
close all

%YOU MAY CHANGE N
N = 64; %stream size; parametric, N-> 8, 16, 32, 64, 128, 256, 512, 1024
i = 1; %for iteration and vector index
number_of_test_iteration = 5000; % total random tests
% We have chosen 5000 like in https://ieeexplore.ieee.org/document/9116492
% that is listed by Reviewer (Reference 1)

% Error accumulators
MUL_MSE_CT_a_best_no_fluctuation(1) = 0; %This is a_best near zero case
MUL_MSE_bit_by_bit(1) = 0; % bit-by-bit processing - Binomial distribution
MUL_MSE_CT_a_best_with_fluctuation(1) = 0; % CT - Binomial distribution

for k = 1:1:number_of_test_iteration %total test iteration, above, you may change the final value
    
    %-----------------Random X1 and X2 scalar selection--------------------
    % https://www.mathworks.com/help/matlab/ref/randi.html
    X1 = randi((N+1),1)-1; %pseudorandom integer from a uniform discrete distribution
    % range -> [0,N]
    
    X2 = randi((N+1),1)-1; %pseudorandom integer from a uniform discrete distribution
    % range -> [0,N]
    %-----------------Random X1 and X2 scalar selection--------------------
    
    %-----------------------Expected Value---------------------------------
    expected_value(i) = ((X1/N)+(X2/N))/2;
    %Division by N is the related probability
    %P_out = (P_X1 + P_X2) / 2
    %P_S = 1/2 -> selection probability
    %-----------------------Expected Value---------------------------------
    
    
    %--------------------BIT-BY-BIT PROCESSING-----------------------------
    % Using Bernoulli Rand Var. (RV) by obtaining Binomial distribution
    % Each bit has X/N prob. to be either success (logic-1) or fail (logic-0)
    % N trials are applied
    X1_binom = binornd(N, (X1/N));
    X1_temp = false(1,(N)) ; %full zeros temporarily
    X1_temp(1:(X1_binom)) = true ;
    X1_stream = X1_temp(randperm(numel(X1_temp)));
    
    X2_binom = binornd(N, (X2/N));
    X2_temp = false(1,(N)) ; %full zeros temporarily
    X2_temp(1:(X2_binom)) = true ;
    X2_stream = X2_temp(randperm(numel(X2_temp)));
    
    S_binom = binornd(N, ((N/2)/N)); %1/2 probability 
    S_temp = false(1,(N)) ; %full zeros temporarily
    S_temp(1:(S_binom)) = true ;
    S_stream = S_temp(randperm(numel(S_temp)));
    
    %%%%%%%%%%%%%%%%%%%%%bit-by-bit logic operation%%%%%%%%%%%%%%%%%%%%%%%%
    first_and = and(X1_stream, S_stream);
    second_and = and(X2_stream, not(S_stream));
    output_bitstream = or(first_and, second_and); % final or
    %%%%%%%%%%%%%%%%%%%%%bit-by-bit logic operation%%%%%%%%%%%%%%%%%%%%%%%%
    
    %TCO at the output (SINCE THIS IS A PHYSICAL BIT PROCESSING, FOLLOWING 'FOR' LOOP COUNTS THE "ONES")
    TCO_bitstream(i) = 0; %Total Count of 1s at the Output Bitstream (a physical stream)
    for m=1:1:N % looping for N times
        if output_bitstream(m) == true
            TCO_bitstream(i) = TCO_bitstream(i) + 1;
        end
    end
    
    % Error using BIT-BY-BIT PROCESSING
    % Mean Sqaure Error (MSE)
    MUL_MSE_bit_by_bit(i) = (expected_value(i) - (TCO_bitstream(i)/N))^2; % accumulating the squared error
    %--------------------BIT-BY-BIT PROCESSING-----------------------------
    
    
    %%%-*-*-*-*-*-*-*-*NO MORE BIT_BY_BIT OPERATIONS-*-*-*-*-*-*-*-*-*-*%%%
    
        
    %-----------------------------CT---------------------------------------
    
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
    
    %without random fluctuation error; PLAIN a_best
    MUL_MSE_CT_a_best_no_fluctuation(i) = (expected_value(i) - ((a_CT3(i) + b_CT3(i) + c_CT3(i))/N))^2;
    
    % Random fluctuation error, err, from the expected value PY = PX1 * PX2
    % This is as explained in
    % https://homes.cs.washington.edu/~armin/PhD_Thesis.pdf , page: 91
    
    err = ((expected_value(i)*(1-expected_value(i)))/N);
    
    % Error using CT (a_best, a.k.a. near zero corr.) including the random fluc.
    MUL_MSE_CT_a_best_with_fluctuation(i) = (expected_value(i) - ((a_CT3(i) + b_CT3(i) + c_CT3(i))/N))^2 + err; % accumulating the squared error
    %-----------------------------CT---------------------------------------
    
    i = i + 1; %for counting iteration
    
end

format long

CT_no_fluctuations = sum(MUL_MSE_CT_a_best_no_fluctuation)/number_of_test_iteration % a_best
bit_by_bit_binomial = sum(MUL_MSE_bit_by_bit)/number_of_test_iteration % bit-by-bit - Binomial Distribution
CT_fluctuations = sum(MUL_MSE_CT_a_best_with_fluctuation)/number_of_test_iteration % a_best with random fluctuations - Binomial Distribution
