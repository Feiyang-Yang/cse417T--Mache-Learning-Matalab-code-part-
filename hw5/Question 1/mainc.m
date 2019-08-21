clear all;
clc;
test=importdata('zip.test.txt');
train=importdata('zip.train.txt');
zip=train;
numBags= 200;

%compute test error(1 vs 3) of an ensemble tree learned from 200 trees
trainsubsample = zip(find(zip(:,1) == 1|zip(:,1) == 3),:);
trainY = trainsubsample(:,1);
trainX = trainsubsample(:,2:257);

testsubsample = test(find(test(:,1) == 1|test(:,1) == 3),:);
testY = testsubsample(:,1);
testX = testsubsample(:,2:257);

[ testerror ] = BaggedTrees2( trainX, trainY,testX,testY,numBags );
testerror1=testerror;
[ testerror2 ] = BaggedTrees2( trainX, trainY,testX,testY,1 );
testerror1=testerror;


%compute test error(3 vs 5) of an ensemble tree learned from 200 trees
trainsubsample = zip(find(zip(:,1) == 5|zip(:,1) == 3),:);
trainY = trainsubsample(:,1);
trainX = trainsubsample(:,2:257);

testsubsample = test(find(test(:,1) == 5|test(:,1) == 3),:);
testY = testsubsample(:,1);
testX = testsubsample(:,2:257);

[ testerror ] = BaggedTrees2( trainX, trainY,testX,testY,numBags );
[ testerror4 ] = BaggedTrees2( trainX, trainY,testX,testY,1 );

%show the error
fprintf('The testerror(1 vs 3) onetree is %.5f\n', testerror2);
fprintf('The testerror(1 vs 3) is %.5f\n', testerror1);

fprintf('The testerror(3 vs 5) onetree is %.5f\n', testerror4);
fprintf('The testerror(3 vs 5) is %.5f\n', testerror);


