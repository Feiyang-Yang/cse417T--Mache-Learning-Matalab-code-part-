function [ overfit_m ] = computeOverfitMeasure( true_Q_f, N_train, N_test, var, num_expts )
%COMPUTEOVERFITMEASURE Compute how much worse H_10 is compared with H_2 in
%terms of test error. Negative number means it's better.
%   Inputs
%       true_Q_f: order of the true hypothesis
%       N_train: number of training examples
%       N_test: number of test examples
%       var: variance of the stochastic noise
%       num_expts: number of times to run the experiment
%   Output
%       overfit_m: vector of length num_expts, reporting each of the
%                  differences in error between H_10 and H_2

%initialize the output as [num_expts*1]
overfit_m = zeros(num_expts,1);

%Run the experiment for the setted times
for i = 1:num_expts
    %Generate training and test sets for the Legendre
    [train_set, test_set] = generate_dataset( true_Q_f, N_train, N_test, sqrt(var));
    %Get Legendre polynomial of Q=2,Q=10
    Legendre_p_2 = computeLegPoly( train_set(:,1), 2);
    Legendre_p_10 = computeLegPoly( train_set(:,1), 10);
    %Do the linear regreesion to make Legendre polynomial of 2 and 10 for training data set
    W2 = glmfit(Legendre_p_2, train_set(:,2),'normal','constant','off');
    W10 = glmfit(Legendre_p_10, train_set(:,2),'normal','constant','off');
    %test set generation
    Legendre_p_2_test = computeLegPoly( test_set(:,1),2 );
    Legendre_p_10_test = computeLegPoly( test_set(:,1),10 );
    %Out of sample error calculation
    Eout_2 = (1/N_test)*sum((W2*Legendre_p_2_test - test_set(:,2)).^2);
    Eout_10 = (1/N_test)*sum((W10*Legendre_p_10_test - test_set(:,2)).^2);
    % Make the difference to get the output
    overfit_m(i,1) = Eout_10 - Eout_2;
end
    






