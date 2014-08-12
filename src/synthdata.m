function [data, targets] = synthdata(points)
% Create synthetic test data with the specified number of data points,
% following the setup specified in Example 1 of Kwak & Choi: "Improved
% Mutual Information Feature Selector for Neural Networks in Supervised
% Learning".
%
% Basically, for uniformly random X,Y in [-0.5,0.5], the three features
% are X, X-Y and Y^2. The binary classification task is to determine
% whether X+0.2Y >= 0.
%
% Possibly stating the obvious: a feature selector should pick features
% 1 and 2. Feature 3 is redundant.

data=zeros(points,3);
targets=zeros(points,1);

X=rand(points,1)-0.5;
Y=rand(points,1)-0.5;

data(:,1) = X;
data(:,2) = X - Y;
data(:,3) = Y .* Y;

for i=1:points
    if X(i)+0.2*Y(i)<0
        targets(i)=0;
    else
        targets(i)=1;
    end
end
