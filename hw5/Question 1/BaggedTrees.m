function [ oobErr ] = BaggedTrees( X, Y, numBags )
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

[m,n]= size(X);%get the size of input data
nu = numBags;
 
 h=zeros(m,1);
 H=h-1;
 h=H;
 oobErr=zeros(1,nu);   
 
    for i=1:nu 
         [newX,idx]=datasample(X,m); %sample data from train data
         newY = Y(idx,1);        
         ct = fitctree(newX,newY);   %build a single tree from train data
         idx=unique(idx);            %
         X2=X;
         X2(idx,:)=0;
         nidx= find(X2(:,1)~=0);
         [m1,n1]=size(nidx);
   
               
   %use the trained tree and out of bag data to predict and build a forest
     
                for k=1:m1   
                     K=nidx(k,:);
                     H(K,i) = predict(ct,X(K,:));
                end
                
   %To a one out of bag data, take a vote from the forest
    
                     for L=1:m
                          realh(L,1) = mode(H(L,find(H(L,:)~=-1)));    
                     end
        
        
   %compute the out of bag error
        error=realh-Y;
        error=error(find(~isnan(error)),1);
        error(find(error~=0),1)=1;
        error=mean(error);
        
     oobErr(1,i)=error;
     H = [H h];
     fprintf('numBags is %.4f\n', i);
 end
end
