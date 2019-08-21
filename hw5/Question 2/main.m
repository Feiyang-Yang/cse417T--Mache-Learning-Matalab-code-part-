%% setting
n_trees = 30;

%% 1V3
load zip.train;
% fprintf('Working on the one-vs-three problem...\n\n');
subsample = zip(find(zip(:,1)==1 | zip(:,1) == 3),:);
Y = subsample(:,1);
X = subsample(:,2:257);

load zip.test;
subsample = zip(find(zip(:,1)==1 | zip(:,1) == 3),:);
[row, column] = size(subsample);
Y_test = subsample(:,1);
X_test = subsample(:,2:column);

err = zeros(n_trees,2);
for i = 1:n_trees
    [err(i,1), err(i,2)] = AdaBoost(X, Y, X_test, Y_test, i);
end

%% plot 1V3

subplot(2,1,1);
hold on 
plot(1:n_trees,err(:,1),'b--');
plot(1:n_trees,err(:,2),'r--');
hold off
title('1v3');
legend('train error','test error');
ylabel('error rate');
xlabel('number of hypotheses');

%% 3V5

load zip.train;
% fprintf('Working on the one-vs-three problem...\n\n');
subsample = zip(find(zip(:,1)==3 | zip(:,1) == 5),:);
Y = subsample(:,1);
X = subsample(:,2:257);

load zip.test;
subsample = zip(find(zip(:,1)==3 | zip(:,1) == 5),:);
[row, column] = size(subsample);
Y_test = subsample(:,1);
X_test = subsample(:,2:column);

err2 = zeros(n_trees,2);
for i = 1:n_trees
    [err2(i,1), err2(i,2)] = AdaBoost(X, Y, X_test, Y_test, i);
end

%% plot 3V5

subplot(2,1,2);
hold on 
plot(1:n_trees,err2(:,1),'b--');
plot(1:n_trees,err2(:,2),'r--');
hold off
title('3v5');
legend('train error','test error');
ylabel('error rate');
xlabel('number of hypotheses');
