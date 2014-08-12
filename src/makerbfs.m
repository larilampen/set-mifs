function net = makerbfs(inputs,outputs,hidden)
% Initialize several radial basis function classifiers, with the specified
% number of inputs, outputs, and hidden nodes. The latter should be
% an array whose size indicates the number of RBFs to create.

for i=1:size(hidden,2)
    net{i}=rbf(inputs,hidden(i),outputs,'gaussian');
end
