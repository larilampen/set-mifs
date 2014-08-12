% --- 1. DATA ---
%
% Prepare input data. Each column represents a feature, each row a data
% vector.

% Create synthetic data.
[data, targets] = synthdata(2000);

% Normalize with regard to mean and standard deviation.
data=normalize(data);

% Discretize (bin) continuous values.
data=discretize(data, 10);

% Partition into training and testing sets.
% in this case, the division is fifty-fifty
[X,T,Xtest,Ttest]=shufdiv(data,targets,1000);


% --- 2. RANKING ---
%
% Compute feature ranking.

ranking=rank_mifsfs(X,T)

% For comparison, to use Battiti's MIFS with beta=1.0, use this line
% instead:
% ranking=rank_mifs(X,T,1.0);


% --- 3. TEST ---
comp_results(ranking,data,targets);
