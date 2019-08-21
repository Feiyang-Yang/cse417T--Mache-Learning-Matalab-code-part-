close all;
clear all;
clc;
test=importdata('zip.test.txt');
train=importdata('zip.train.txt');
zip=train;


numBags= 300;
Ynumbags = zeros(1,numBags);
Y = zip(:,1);
X = zip(:,2:257);

%subsample = zip(find(zip(:,1) == 1|zip(:,1) == 3|zip(:,1) == 2|zip(:,1) == 4),:);
% subsample = zip(find(zip(:,1) == 1|zip(:,1) == 3),:);
% Y = subsample(:,1);
% X = subsample(:,2:257);

[oobErr] = BaggedTrees( X, Y, numBags );
x=1:numBags;
plot(x,oobErr);
xlabel('numBags');
ylabel('out of bag error');




