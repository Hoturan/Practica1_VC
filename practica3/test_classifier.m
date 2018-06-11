
%first we must construct the dataset in matrix form
%[X, y] = get_dataset();

%feature scaling (standardization)
% mu = mean(X);
% sigma = std(X);
% for i = 1:size(X,2)
%   X(:,i) = (X(:,i) - mu(i)) / sigma(i);
% end

%missclassification rate
cp = cvpartition(y,'k',10); % Stratified cross-validation
classf = @(XTRAIN, ytrain,XTEST)(my_crossvalfun(XTRAIN,ytrain,XTEST));
cvMCR = crossval('mcr',X,y,'predfun',classf,'partition',cp)


%confusion matrix
order = unique(y); % Order of the group labels
cp = cvpartition(y,'k',10); % Stratified cross-validation
f = @(xtr,ytr,xte,yte)confusionmat(yte,my_crossvalfun(xtr,ytr,xte),'order',order);
cfMat = crossval(f,X,y,'partition',cp);
size(sum(cfMat))
cfMat = reshape(sum(cfMat),12,12);
%normalize matrix (in rounded percentage)
for r=1:12
    cfMat(r,:) = round(cfMat(r,:)./sum(cfMat(r,:)).*100);
end

cfMat

