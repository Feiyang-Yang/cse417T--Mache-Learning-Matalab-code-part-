% Training
train_data = csvread('clevelandtrain.csv',1,0); % read the CSV file from second row to get data numbers
[m,n] = size(train_data); % m is row_Num of train_data, n is col_Num of train_data
w_init = zeros(n,1); % initial value of the w vector (d+1 dimensional)
%max_its = 10000; % maximum number of iterations to run for
%max_its = 100000;
max_its = 10000000;
eta = 0.0001; % learning rate, setted in the question stem

X_train = train_data(:,1: (n-1)); % Data matrix X get the data from CSV file except the lables
y_train = train_data(:,n); % data lables y get the last colum of the CSV file
y_train = y_train * 2 - 1; % convert lables from 0/1 to -1/+1

tic 
[ w_train, e_in_train, i_train ] = logistic_reg( X_train, y_train, w_init, max_its, eta ); % call the function
toc

train_error = find_test_error( w_train, X_train, y_train ); % call the function

% Testing
test_data = csvread('clevelandtest.csv',1,0); % read the CSV file from second row to get data numbers
[mm, nn] = size(test_data); % mm is row_Num of test _data, nn is col_Num 

X_test = test_data(:,1: (nn-1)); % Data matrix X get the data from CSV file except the lables
y_test = test_data(:,nn); % data lables y get the last colum of the CSV file
y_test = y_test * 2 - 1; % convert lables from 0/1 to -1/+1


test_error = find_test_error( w_train, X_test, y_test ); % call the function




% Train and test a logistic regression model using the inbuilt matlab function glmfit()
y_train = train_data(:,n); % To use binomial, read the original label again
tic
w_glmfit = glmfit(X_train,y_train,'binomial');
toc

% test the error of glmfit()
test_error_glmfit = find_test_error( w_glmfit, X_test, y_test );



% New feature and zscore(), and test the new data
% Try different magnitude of eta

%y_train has been changed to 0/1, now make it +1/-1 again
y_train = train_data(:,n); % data lables y get the last colum of the CSV file
y_train = y_train * 2 - 1; % convert lables from 0/1 to -1/+1


X_train_z = zscore(X_train) % change X_train to zscore
[ w_train_z, e_in_z, i_z ] = logistic_reg( X_train_z, y_train, w_init, max_its, eta ); % call the function

% Do the test
test_error_z = find_test_error( w_train_z, X_test, y_test );
