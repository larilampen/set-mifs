function d = prune(data,features,k)
% Given data set and list of features, remove the features whose indices
% are in the k first items of the given list of features.

d=zeros(size(data,1),size(data,2)-k);
i=1;

for j=1:size(data,2)
    skip=0;
    for jj=1:k
        if features(jj)==j
            skip=1;
        end
    end
    if skip==0
        d(:,i)=data(:,j);
        i=i+1;
    end
end
