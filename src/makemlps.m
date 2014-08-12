function net = makemlps(inputs,outputs,hidden)
% Initialize several multilayer perceptron classifiers, with the specified
% number of inputs, outputs and hidden units. The latter should be
% an array whose size indicates the number of MLPs to create.

for i=1:size(hidden,2)
    net{i} = mlp(inputs,hidden(i),outputs,'logistic');
end
