% --- 1. DATA ---
%
% Prepare input data. Each column represents a feature, each row a data
% vector.

% Read input data. The example uses the Wisconsin Diagnostic Breast Cancer
% data set, available from
% http://archive.ics.uci.edu/ml/machine-learning-databases/breast-cancer-wisconsin/
raw1=dlmread('wdbc.data',',');

% Throw away first row
raw1=raw1(:,2:32);

% Separate input features from targets (first column).
targets=raw1(:,1);
data=raw1(:,2:size(raw1,2));

% Normalize with regard to mean and standard deviation.
data=normalize(data);

% Discretize (bin) continuous values.
data=discretize(data, 10);

% Store number of features.
features = size(data,2);

% Use 10-fold cross-validation.
folds=10;

results=zeros(features+1,folds);
for c=1:folds
    % --- Partition into training and testing sets.
    [X,T,Xtest,Ttest] = split_crossval(data,targets,c,folds);

    % --- 2. RANKING ---
    %
    % Compute feature ranking.

    ranking1=rank_mifsfs(X,T)

    % --- 3. TEST ---
    [acc] = comp_results_crossval(ranking1,X,T,Xtest,Ttest);
    results(:,c)=acc;
end

results=results';

% Output means and standard deviations of each of the crossvalidation
% tests. Note the results are ordered in decreasing order of feature
% subset size.
r_means=mean(results)
r_std=std(results)
