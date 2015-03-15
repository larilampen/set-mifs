function win = vote(acts)
% Find the results of a majority vote of classifiers given a matrix of
% activations. Returns array of numbers indicating winning entries.

% take a "poll"
voting=zeros(size(acts,1),size(acts,3));
for i=1:size(acts,3)
    [ignore,ind] = max(acts(:,:,i)');
    voting(:,i)=ind';
end

% find the winner of each vote
win=zeros(size(acts,1),1);
for i=1:size(acts,1)
    [ignore,win(i)]=max(histc(voting(i,:),[1:size(acts,2)]));
end
