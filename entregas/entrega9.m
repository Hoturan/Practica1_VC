%% Arnau Badia && David Williams
load fisheriris
x = meas(:,1:2);
y = categorical(species);
labels=categories(y);
gscatter(x(:,1),x(:,2),species,'rgb','osd');
xlabel('sepal width')
xlabel('sepal length')
ylabel('sepal width')
cl{1}=fitcnb(x,y);
cl{2}=fitcdiscr(x,y);
cl{3}=fitctree(x,y);
cl{4}=fitcknn(x,y);
noms={'Bayes', 'LDA', 'tree', 'Knn'}
x1rang=min(x(:,1)):.01:max(x(:,1));
x2rang=min(x(:,2)):.01:max(x(:,2));
[xx1 xx2]=meshgrid(x1rang, x2rang);
xgrid = [xx1(:) xx2(:)];
figure
for i=1:4
    sp_pred=predict(cl{i},xgrid);
    subplot(2,2,i);
    gscatter(xx1(:),xx2(:),sp_pred,'rgb');
    title(noms{i})
end

cl{1}=fitcnb(meas,y);
nbcl=resubPredict(cl{1});
nberr=resubLoss(cl{1})
[CM ordre]=confusionmat(y,nbcl)

cl{2}=fitcdiscr(meas,y);
ldacl=resubPredict(cl{2});
ldaerr=resubLoss(cl{2})

cl{3}=fitctree(meas,y);
treecl=resubPredict(cl{3});
treeerr=resubLoss(cl{3})

cl{4}=fitcknn(meas,y);
knncl=resubPredict(cl{4});
knnerr=resubLoss(cl{4})

cp=cvpartition(species, 'KFold',10);
cvnb=crossval(cl{1},'CVPartition',cp);
nbcverr=kfoldLoss(cvnb);

cvlda=crossval(cl{2},'CVPartition',cp);
ldacverr=kfoldLoss(cvlda)

