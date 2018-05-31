function ytest = my_crossvalfun(XTRAIN,ytrain,XTEST)
clf = fitcdiscr(XTRAIN,ytrain);
ytest = predict(clf,XTEST);
end

