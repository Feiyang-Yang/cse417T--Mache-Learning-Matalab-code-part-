function [ testerror ] = BaggedTrees2( trainX, trainY,testX,testY,numBags )
%BAGGEDTREES Returns out-of-bag classification error of an ensemble of
%numBags CART decision trees on the input dataset, and also plots the error
%as a function of the number of bags from 1 to numBags
%   Inputs:
%       X : Matrix of training data
%       Y : Vector of classes of the training examples
%       numBags : Number of trees to learn in the ensemble
%
%   You may use "fitctree" but do not use "TreeBagger" or any other inbuilt
%   bagging function

[m,n]= size(trainX);%get the size of train data
[m1,n1]=size(testX);%get the size of test data
nu = numBags;


  for i=1:nu  
     [newX,idx]=datasample(trainX,m);%sample data from train data
     newY = trainY(idx,1);
     ct = fitctree(newX,newY);
     
        for k=1:m1  
           H(k,i) = predict(ct,testX(k,:));%use the trained tree to predict one test tree
        end
 
    
          fprintf('numBags is %.4f\n', i);     
  end
  
  %after building all the trees on test data, compute the test error 
        for L=1:m1
             realh(L,1) = mode(H(L,:));%get a vote from each test data point
        end
        
        error=realh-testY;
        error(find(error~=0),1)=1;
        testerror=mean(error);
        
end
