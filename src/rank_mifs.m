function rank = rank_mifs(X,T,beta)
% Rank features using the greedy feature selection algorithm MIFS (Battiti
% 1994).
% Returns an array with feature numbers in order, most significant LAST.

% Find number of features.
nf=size(X,2);

% Initialize F as the full set of features and S as the empty set
% (sets are encoded as arrays of indices to the data matrix).
F=1:nf;
S=[];

% Handle representation of classes by mapping to an integer in the
% interval [1,classes].
classes=size(T,2);
cl=zeros(size(T,1),1);
for i=1:size(T,1)
    for k=1:classes
        if T(i,k)==1
            cl(i)=k;
            break;
        end
    end
end

% Choose first feature: go through the features in set F and find the
% one f with maximum I(C;f), where C is the class vector (targets).
class_mi=zeros(nf,1);
max_mi=0;
max_idx=0;
for curfeat=1:nf
    % Compute MI between current feature and the class.
    curmi=mi(X(:,curfeat),cl);
    fprintf('Feature #%d has MI %f\n',curfeat,curmi);
    class_mi(curfeat)=curmi;
    if curmi>max_mi
        max_mi=curmi;
        max_idx=curfeat;
    end
end
fprintf('First choice: feature #%d with maximal MI %f\n',max_idx,max_mi);
% Remove first choice feature from F and add to S.
F(max_idx)=[];
S(length(S)+1)=max_idx;

% Here's the greedy feature ranking part.

while length(F)>0
    % initialize with an unrealistically small number
    max_magic=-beta*nf;
    max_idx=0;
    for p=1:length(F)
        f=F(p);
        magic=class_mi(f);
        for q=1:length(S)
            s=S(q);
            tmp = mi(X(:,f),X(:,s));
            magic = magic - beta*tmp;
        end
        if magic>max_magic
            max_magic=magic;
            max_idx=p;
        end
    end
    % move next chosen feature from S to F
    fprintf('Next choice: feature #%d with magic %f\n',F(max_idx),max_magic);
    S(length(S)+1)=F(max_idx);
    F(max_idx)=[];
end

% Return ranking of features. Once again, the most significant feature is
% the *last* one.
rank=S(length(S):-1:1);
rank=rank';
