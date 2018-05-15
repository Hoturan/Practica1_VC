
%first we must construct the dataset in matrix form
[X, y] = get_dataset();

%podem fer experiments amb altres models
clf = fitctree(X,y);

%% provisional: aqui fer cross validation o el que sigui

%missclassification rate
cp = cvpartition(y,'k',10); % Stratified cross-validation
classf = @(XTRAIN, ytrain,XTEST)(classify(XTEST,XTRAIN,ytrain));
cvMCR = crossval('mcr',X,y,'predfun',classf,'partition',cp)

%confusion matrix
order = unique(y); % Order of the group labels
cp = cvpartition(y,'k',10); % Stratified cross-validation
f = @(xtr,ytr,xte,yte)confusionmat(yte,classify(xte,xtr,ytr),'order',order);
cfMat = crossval(f,X,y,'partition',cp);
cfMat = reshape(sum(cfMat),12,12)

