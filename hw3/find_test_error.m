function [ test_error ] = find_test_error( w, X, y )
%FIND_TEST_ERROR Find the test error of a linear separator
%   This function takes as inputs the weight vector representing a linear
%   separator (w), the test examples in matrix form with each row
%   representing an example (X), and the labels for the test data as a
%   column vector (y). X does not have a column of 1s as input, so that 
%   should be added. The labels are assumed to be plus or minus one. 
%   The function returns the error on the test examples as a fraction. The
%   hypothesis is assumed to be of the form (sign ( [1 x(n,:)] * w )

% Get the size of the input, the test examples in matrix form with each row representing an example (X)
[m,n] = size(X);
% X does not have a column of 1s as input, so that should be added
X1 = ones(m,1);
X = [X1, X];

% Express the logistic regression function
S = w'*X'; % The variable equals weight vector times the data matrix
% The expression of logistic regression function
% Above 0.5 the sign is +1, smaller than 0.5 the sign is -1
h = sign(exp(S)./(1+exp(S))-0.5); 

% Get the difference of the component in h and input lable y, the get the
% number of the different component, and calculate the ration of number in
% the total data number
test_error = 1/2*(sum(abs(h' - y))/m);

end

