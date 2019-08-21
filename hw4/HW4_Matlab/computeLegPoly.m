function [ z ] = computeLegPoly( x, Q )
%COMPUTELEGPOLY Return the Qth order Legendre polynomial of x
%   Inputs:
%       x: vector (or scalar) of reals in [-1, 1]
%       Q: order of the Legendre polynomial to compute
%   Output:
%       z: matrix where each column is the Legendre polynomials of order 0 
%          to Q, evaluated atthe corresponding x value in the input


% z=m*(Q+1),so get m here
[m,~] = size(x);
% As expressed in the stem of Pro 4.3，1 for L0(x) 
if(Q>=0)
    z(1:m,1) = 1;
end

% As expressed in the stem of Pro 4.3，x for L1(x) 
if((Q-1)>=0)
    z(:,2) = x;
end

% As expressed in the stem of Pro 4.3，from L2(x) there exist an expression
% for iteration, for loop until Qth component is executed
if((Q-2)>=0)
    for i=2:Q
        z(:,i+1) = (2*i-1)/i*x.*z(:,i) - (i-1)/i*z(:,i-1);
    end
end
end

