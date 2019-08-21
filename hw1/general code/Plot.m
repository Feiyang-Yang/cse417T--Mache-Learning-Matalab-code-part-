%100samples, 11 dimensions,1000 experiments
[ num_iters bounds] = perceptron_experiment ( 100,  11, 1000 );  
a=num_iters;
b=bounds;

b = log(abs(a-b));

%Plot one by one, not in the same picture
histogram(a,30);
histogram(b,30);