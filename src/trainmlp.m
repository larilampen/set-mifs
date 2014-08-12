function tnet = trainmlp(net,X,T,cycles,momentum,learn)
% Train a multilayer perceptron with the given parameter values. Returns
% the trained network.
%
% hidden - number of hidden nodes
% momentum - obvious
% learn - learning rate
% cycles - number of evaluation cycles
% X - training data
% T - training true classes


opts = foptions;
% debug flag
% opts(1)=1;
opts(5)=1;
opts(14)=cycles;
opts(17)=momentum;
opts(18)=learn;

tnet=olgd(net,opts,X,T);
