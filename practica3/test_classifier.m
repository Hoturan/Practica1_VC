
%first we must construct the dataset in matrix form
%[X, y] = get_dataset();

%feature scaling (standardization)
% mu = mean(X);
% sigma = std(X);
% for i = 1:size(X,2)
%   X(:,i) = (X(:,i) - mu(i)) / sigma(i);
% end



%podem fer experiments amb altres models
%clf = fitctree(X,y);

%LDA va bastante bien
clf = fitcdiscr(X,y);

X(1,:);

%% provisional: aqui fer cross validation o el que sigui

%missclassification rate
cp = cvpartition(y,'k',10); % Stratified cross-validation
%classf = @(XTRAIN, ytrain,XTEST)(classify(XTEST,XTRAIN,ytrain));
%classf = @(XTRAIN, ytrain,XTEST)
%cvMCR = crossval('mcr',X,y,'predfun',classf,'partition',cp)
classf = @(XTRAIN, ytrain,XTEST)(my_crossvalfun(XTRAIN,ytrain,XTEST));
cvMCR = crossval('mcr',X,y,'predfun',classf,'partition',cp)


%confusion matrix
order = unique(y); % Order of the group labels
cp = cvpartition(y,'k',10); % Stratified cross-validation
%f = @(xtr,ytr,xte,yte)confusionmat(yte,classify(xte,xtr,ytr),'order',order);
f = @(xtr,ytr,xte,yte)confusionmat(yte,my_crossvalfun(xtr,ytr,xte),'order',order);
cfMat = crossval(f,X,y,'partition',cp);
size(sum(cfMat))
cfMat = reshape(sum(cfMat),12,12);
%normalize matrix (in rounded percentage)
for r=1:12
    cfMat(r,:) = round(cfMat(r,:)./sum(cfMat(r,:)).*100);
end

cfMat

clf = fitcdiscr(X,y);

