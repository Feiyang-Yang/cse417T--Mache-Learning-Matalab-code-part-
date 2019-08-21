function [ num_iters bounds] = perceptron_experiment ( N,  d, num_samples )
%perceptron_experiment Code for running the perceptron experiment in HW1
%   Inputs: N is the number of training examples
%           d is the dimensionality of each example (before adding the 1)
%           num_samples is the number of times to repeat the experiment
%   Outputs: num_iters is the # of iterations PLA takes for each sample
%            bounds is the theoretical bound on the # of iterations
%              for each sample

%      (both the outputs should be num_samples long)


%initialize the num_iters
num_iters = zeros(1,N);

%do the experiments "num_samples" times
for i=1:num_samples    
    
  % Initialization of random values for input between (-1,1)
  m = 2*rand(d,N)-1;
  
  % Initialization of weight vector
  w = rand(d-1,1);
  w = [0;w]; %add the first colum and set it as 0

  % Number of iterations
  t = zeros(1,N);

   % Solving for training set output values, y
  y = sign(w'*m);


%create a set of data
data = [m;y];

data = data';

[ w iterations ] = perceptron_learn( data );% use the PLA to get the each experiment's iteration

num_iters(:,i)=iterations;   %output all the iterations of all experiments

%compute the bound each experiment

   for j=1:N
       R(j)= sqrt(sum(m(:,j).^2)) ;  
       lo(j)= y(j)*(w'*m(:,j));     
   end
   lengthw = sum(w.^2)
   R=max(R);
   lo = min(lo);
   bounds(i) = ((R.^2)*lengthw)./lo.^2;

 
end

