function [ wt, e_in,i ] = logistic_reg( X, y, w_init, max_its, eta )
%LOGISTIC_REG Learn logistic regression model using gradient descent
%   Inputs:
%       X : data matrix (without an initial column of 1s)
%       y : data labels (plus or minus 1)
%       w_init: initial value of the w vector (d+1 dimensional)
%       max_its: maximum number of iterations to run for
%       eta: learning rate
    
%   Outputs:
%       w : weight vector
%       e_in : in-sample error (as defined in LFD)

% Get the size of the input, the test examples in matrix form with each row representing an example (X)
[m,n] = size(X);
% We will add a column of 1s
n = n+1; 
% X does not have a column of 1s as input, so that should be added
X1 = ones(m,1);
X = [X1, X];

i = 0; % initilize the iteration controller
g_t = ones(1,n); % initialize the gradient bariable gt
wt = w_init; % Initialize the wight variable wt and assign the input w_init to initialize wt

% While the iteration number has not been enough
% or the magnitude of each term in the gradient is above what we set at any step
while((i < max_its) && (max(abs(g_t))>10^(-6)))  % 10^(-6)
    % the expression of gt in Page 95 of the notebook
    ex = exp(y'.*(wt'*X'));
    g_t = X'*(y'./(1+ex))'/(-m);
    % Update the weight wt according to Page 95 of the notebook, eta is the
    % input of the learning rate
    wt = wt - eta*g_t;
    % add one to the iteration controller
    i = i+1;
end

% Calculate e_in
e_in_total = 0; % Innitialize the total sum of each e_in
r = 1; % initialize the loop controller
while (r <= m)
    % the expression in Page 95 of the notebook
    e_in_total = e_in_total + log(1+exp(-y(r)*wt'*(X(r,:)'))); 
    r = r+1;
end    
% the expression in Page 95 of the notebook
e_in = e_in_total/m; 

end

