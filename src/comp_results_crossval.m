function [resmean] = comp_results_crossval(ranking,X,T,Xtest,Ttest)
% This is the same as comp_results except used with crossvalidation.

iterations=1;
Nm=1;

features=size(X,2);

resmean=zeros(features+1,1);
ressd=zeros(features+1,1);
for delfeat=0:features
    fprintf('\n*** Removed features: %d/%d ***\n',delfeat,features);
    prunedX=prune(X,ranking,delfeat);
    prunedXtest=prune(Xtest,ranking,delfeat);
    avgresult=zeros(1,iterations);
    for z=1:iterations
        fprintf('Iteration %d/%d\n',z,iterations);
        % create arrays of random values for parameters (h=learning rate,
        % m=momentum, cyc=number of cycles)
        hidden=round(rvals(5,30,Nm));
        cyc=round(rvals(3,50,Nm));
        h=rvals(0.01,0.15,Nm);
        m=rvals(0.01,0.3,Nm);

        cyc=50;
        hidden=50;
        m=0.0005;
        h=0.0005;

        % Initialise nets with initial weights and params.
        mnet=makemlps(size(prunedX,2),size(T,2),hidden);

        for i=1:Nm
            % train MLP
            trainednet{i}=trainmlp(mnet{i},prunedX,T,cyc(i),m(i),h(i));
        end

        % train and test MLPs, store activations
        for i=1:Nm
            MLPAct(:,:,i)=mlpfwd(trainednet{i},prunedXtest);
        end
        AvgAct=mean(MLPAct,3);
        [conf,rate]=confmat(AvgAct,Ttest);
        avgresult(z)=rate(1);
    end
    resmean(delfeat+1)=mean(avgresult);
    ressd(delfeat+1)=std(avgresult);
end

fprintf(1,'Deleted features\tMean(%%)\tSd\n');
for i=1:length(resmean)
    fprintf(1,'%d\t%3.2f\t%f\n',i-1,resmean(i),ressd(i));
end

fprintf(1,'Features\tMean(%%)\tSd\n');
for i=1:length(resmean)
    fprintf(1,'%d\t%3.2f\t%f\n',features-(i-1),resmean(i),ressd(i));
end

