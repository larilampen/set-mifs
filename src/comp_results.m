function comp_results(ranking,data,targets)
% Run some classifiers (MLPs) on feature subsets of the given data based
% on the provided ranking of features. An averaging ensemble classifier is
% used.
%
% Note at the moment, this function simply prints out the data instead of
% returning it.

iterations=3;
Nm=5;

resmean=zeros(size(data,2)+1,1);
ressd=zeros(size(data,2)+1,1);
for delfeat=0:size(data,2)
    fprintf('\n*** Removed features: %d of %d ***\n',delfeat,size(data,2));
    pruneddata=prune(data,ranking,delfeat);
    avgresult=zeros(1,iterations);
    voteresult=zeros(1,iterations);
    for z=1:iterations
        fprintf('Iteration %d of %d\n',z,iterations);
        % create arrays of random values for parameters (h=learning rate,
        % m=momentum, cyc=number of cycles)
        hidden=round(rvals(5,30,Nm));
        cyc=round(rvals(3,50,Nm));
        h=rvals(0.01,0.15,Nm);
        m=rvals(0.01,0.3,Nm);

%        cyc=50;
%        hidden=50;
%        m=0.0005;
%        h=0.0005;

        % Initialise nets with initial weights and params.
        mnet=makemlps(size(pruneddata,2),size(targets,2),hidden);

        % To use RBFs instead of MLPs, change above call to use makerbfs
        % instead of makemlps, and change the training part below.

        % separate data into training and testing sets
        [X,T,Xtest,Ttest]=shufdiv(pruneddata,targets,round(size(pruneddata,1)/2));
        for i=1:Nm
            % train MLP
            trainednet{i}=trainmlp(mnet{i},X,T,cyc(i),m(i),h(i));
        end

        % train and test MLPs, store activations
        for i=1:Nm
            MLPAct(:,:,i)=mlpfwd(trainednet{i},Xtest);
        end
        AvgAct=mean(MLPAct,3);
        [conf,rate]=confmat(AvgAct,Ttest);
        avgresult(z)=rate(1);
        VoteAct=vote(MLPAct);
        [conf,rate]=confmat(VoteAct,Ttest);
        voteresult(z)=rate(1);
    end
    resmean(delfeat+1)=mean(avgresult);
    ressd(delfeat+1)=std(avgresult);
end

fprintf(1,'Deleted features\tMean(%%)\tSd\n');
for i=1:length(resmean)
    fprintf(1,'%d\t%3.2f\t%f\n',i-1,resmean(i),ressd(i));
end

