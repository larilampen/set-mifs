function [data] = discretize(data, bins)
% Return the given data array discretised into the specified number of
% bins of equal width. The returned array contains bin labels (not values).
% If the array is already discrete, it is not modified.

features = size(data,2);

for i=1:features
    values=data(:,i);
    % only discretize if not already discrete
    if length(unique(values))>bins
        vmax=max(values);
        vmin=min(values);
        vbin=(vmax-vmin)/bins;
        for k=1:size(values)
            num=floor((values(k)-vmin)/vbin);
            % ensure the end point of the interval is correctly mapped
            if num==bins
                num=bins-1;
            end
            values(k)=num;
        end
        data(:,i)=values;
    end
end
