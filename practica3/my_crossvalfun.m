function ytest = my_crossvalfun(XTRAIN,ytrain,XTEST)
%clf = fitcdiscr(XTRAIN,ytrain,'DiscrimType','diagquadratic');
%clf = fitcnb(XTRAIN,ytrain, 'DistributionNames','kernel', 'Kernel','box'); %47
%clf = fitcnb(XTRAIN,ytrain); %40
%clf = fitctree(XTRAIN,ytrain); %55
%clf = fitcensemble(XTRAIN,ytrain); %40
%clf = fitcecoc(XTRAIN,ytrain); %34
clf = fitcdiscr(XTRAIN,ytrain); %29 
ytest = predict(clf,XTEST);
end

