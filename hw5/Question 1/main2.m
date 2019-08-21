clear all;
clc;
test=importdata('zip.test.txt');
train=importdata('zip.train.txt');
zip=train;

numBags= 150;
subsample = zip(find(zip(:,1) == 1|zip(:,1) == 3),:);
Y = subsample(:,1);
X = subsample(:,2:257);
[oobErr] = BaggedTrees( X, Y, numBags ); %compute out of bag error
ct = fitctree(X,Y,'CrossVal','on');
kf=ct.kfoldLoss;     %%compute cross-validation error
oob=oobErr(1,numBags);

subsample2 = zip(find(zip(:,1) == 5|zip(:,1) == 3),:);
Y = subsample2(:,1);
X = subsample2(:,2:257);
[oobErr] = BaggedTrees( X, Y, numBags );%compute out of bag error
ct = fitctree(X,Y,'CrossVal','on');  

fprintf('The cross-validation error (1 vs 3) is %.5f\n', kf);
fprintf('The OOBERR(1 vs 3) is %.5f\n', oob);

fprintf('The cross-validation error (3 vs 5) is %.5f\n', ct.kfoldLoss);
fprintf('The OOBERR(3 vs 5) is %.5f\n', oobErr(1,numBags));
