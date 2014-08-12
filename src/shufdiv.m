function [X,T,Xtest,Ttest] = shufdiv(data,targets,training)
% Given data set and associated targets, return a training set of
% specified size and a testing set with the rest of the data, with the
% order of the contents shuffled.

shuf=randperm(size(data,1));

% Obviously, the test set and targets have to be shuffled using the same
% permutation.
X=data(shuf,:);
T=targets(shuf,:);

% separate data into training and testing sets
Xtest=X(training+1:size(X,1),:);
Ttest=T(training+1:size(T,1),:);
X=X(1:training,:);
T=T(1:training,:);
