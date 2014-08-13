function [labels] = relabel(data)
% Label values in the given array, i.e. lowest value replaced by 0,
% second lowest by 1, etc.
% If a matrix is given, do the above for each row individually.

features=size(data,2);
labels=zeros(size(data));

for r=1:features
    values=data(:,r);
    indices=1:length(values);
    counter=0;

    while ~isempty(indices)
        m=min(values(indices));
        for i=length(indices):-1:1
            ind=indices(i);
            if values(ind)==m
                labels(ind,r)=counter;
                indices(i)=[];    
            end
        end
        counter = counter+1;
    end
end
