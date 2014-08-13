function [X,T,Xtest,Ttest] = split_crossval(data,targets,num,chunks)
% N-fold crossvalidation: separate data and targets using
% "chunks": total no. of segments (ie. N)
% "num": the number of current segment (range 1 to "chunks")

% Adjust to start from 0.
num=num-1;

% Compute chunk size.
n=size(data,1);
siz=n/chunks;

% Find start and end points. Round down except for the last chunk.
tstart=floor(num*siz+1);
if num==chunks
    tend=n;
else
    tend=floor(num*siz+siz);
end

X=[data(1:tstart-1,:)
   data(tend+1:n,:)];
T=[targets(1:tstart-1,:)
   targets(tend+1:n,:)];
Xtest=data(tstart:tend,:);
Ttest=targets(tstart:tend,:);
