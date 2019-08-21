function [ train_err, test_err ] = AdaBoost( X_tr, y_tr, X_te, y_te, n_trees )
%AdaBoost: Implement AdaBoost using decision stumps learned
%   using information gain as the weak learners.
%   X_tr: Training set
%   y_tr: Training set labels
%   X_te: Testing set
%   y_te: Testing set labels
%   n_trees: The number of trees to use

%%  training

    [row, column] = size(X_tr);
    diff = (max(y_tr)+min(y_tr))/2;
    y_tr = y_tr - diff;
    alph = zeros(n_trees,1);
    % g = zeros(row,n_trees);
    train_y = zeros(row,1);
    h = cell(n_trees); %cell
    w = ones(row,1)/row;
    for i=1:n_trees
        h{i} = fitctree(X_tr,y_tr,'MaxNumSplits',1,'SplitCriterion','deviance','Weights',w);
        % h{i} = fitctree(X_tr,y_tr,'minparent',size(row,1),'prune','off','mergeleaves','off','weights',w);
%         view(h{i}.Trained{1},'Mode','graph');
        
%         disp(i);
        g = predict(h{i},X_tr);
        bool = double(g~=y_tr);
        
        % debug
%         count2 = hist(y_tr,unique(y_tr));
%         disp(unique(y_tr));
%         disp(count2);
%         count1 = hist(g,unique(g));
%         disp(unique(g));
%         disp(count1);
%         count3 = hist(bool,unique(bool));
%         disp(unique(bool));
%         disp(count3);
%         disp(y_tr(1:10)');
%         disp(g(1:10)');
%         disp(bool(1:10)');

        epsilon = sum(w.*bool);
%         disp(epsilon);
        alph(i) = (log(1-epsilon)-log(epsilon))/2;
%         disp(alph(i));
        w = w.*exp(-alph(i).*y_tr.*g);
%         disp('w');
%         disp(sum(w));
        w = w./sum(w);
%         disp(sum(w));
        train_y = train_y + alph(i).*g;
        
%         disp(train_y(1:10,1)');
%         temp = sign(g);
%         temp = sum(temp~=y_tr);
%         disp(temp);
    end
%     disp(train_y);
    train_y = sign(train_y);
    train_err = sum(train_y~=y_tr);
%     disp(train_err);
    train_err = train_err/row;
    
%%  testing
    [row, column] = size(X_te);
    test_y = zeros(row,1);
    y_te = y_te - diff;
    for i = 1:n_trees
        test_y = test_y + alph(i).*predict(h{i},X_te);
    end
    test_y = sign(test_y);
    test_err = sum(test_y~=y_te);
    test_err = test_err/row;
end

