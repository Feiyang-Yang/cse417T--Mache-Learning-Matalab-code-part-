function [ train test ] = generate_dataset( Q_f, N_train, N_test, sqrted_sigma )
%GENERATE_DATASET Generate training and test sets for the Legendre
%polynomials example
%   Inputs:
%       Q_f: order of the hypothesis
%       N_train: number of training examples
%       N_test: number of test examples
%       sigma: standard deviation of the stochastic noise
%   Outputs:
%       train_set and test_set are both 2-column matrices in which each row
%       represents an (x,y) pair


%norm is the value of the add-expression in stem of Q1 (a)
norm = 0;
for q = 0:Q_f
    norm = 1/(2*q+1) + norm;
end

%initialize a as random number, in mean 0 and standard deviation 1, (Q_f+1)*1
%change for calculating x to generate y
a = normrnd(0,1,Q_f+1,1);
a = a/sqrt(norm);
% generate random number for noise in train and test
epsilon_test = normrnd(0,1,N_test,1);
epsilon_train = normrnd(0,1,N_train,1);

%generate x in [-1,1] evenly distributed
%generate corresponding y as expression in Pro4.4, y= f(x)+ sigma* epsilon
test_x = 2*rand([N_test,1]) - 1;
test_y = computeLegPoly(test_x, Q_f)*a + (sqrted_sigma)*epsilon_test;
train_x = 2*rand([N_train,1]) - 1;
train_y = computeLegPoly(train_x, Q_f)*a + (sqrted_sigma)*epsilon_train;

%Output
test = [test_x test_y];
train = [train_x train_y];
end

