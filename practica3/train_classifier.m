
%first we must construct the dataset in matrix form
[X, y] = get_dataset();

%feature scaling (standardization)
% mu = mean(X);
% sigma = std(X);
% for i = 1:size(X,2)
%   X(:,i) = (X(:,i) - mu(i)) / sigma(i);
% end

clf = fitcdiscr(X,y);

