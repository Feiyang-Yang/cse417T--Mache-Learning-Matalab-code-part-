function [ w iterations ] = perceptron_learn( data_in )
%perceptron_learn Run PLA on the input data
%   Inputs: data_in: Assumed to be a matrix with each row representing an
%                    (x,y) pair, with the x vector augmented with an
%                    initial 1, and the label (y) in the last column 
%   Outputs: w: A weight vector (should linearly separate the data if it is
%               linearly separable)
%            iterations: The number of iterations the algorithm ran for


s = data_in';

[r,c]=size(s);

% # of iterations
t = zeros(1,100);

%get the label(y)
y = s(r,:);

%get x
s(r,:)=[];

% initializing weight vector
w1 = zeros(r-1,1);

% k -> # of misclassifications
k=0;
% Another counter
ok=0;
j = 0;
i = 0;
while(ok==0)
    for i=1:100
        % If wrongly classified, then update k
        % also update weight vector, w1
        if (sign(w1'*s(:,i)) ~= y(i)) 
            k=k+1;%get iterations
            % Target output predicted by  weight vector
            w1=w1+y(i)*s(:,i); %update w1
      
        else
            if (i == 100) %if all data points are checked, break the loop
                ok = 1;
              
                break;
            else
                j = j + 1; %count the numbers
               
                continue;
            end
        end
    end
end

iterations = k; %output the iterations
w = w1          %output the final weight vector

end

