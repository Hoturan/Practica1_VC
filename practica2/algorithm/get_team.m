function [result] = get_team(im)

global acmilan1 acmilan2 acmilan3
global barcelona1 barcelona2 barcelona3
global chelsea1 chelsea2 chelsea3
global juventus1 juventus2 juventus3
global liverpool1 liverpool2 liverpool3
global madrid1 madrid2 madrid3
global psv1 psv2 psv3


s1 = repmat(realmax,1,3);
s2 = repmat(realmax,1,3);
s3 = repmat(realmax,1,3);
s4 = repmat(realmax,1,3);
s5 = repmat(realmax,1,3);
s6 = repmat(realmax,1,3);
s7 = repmat(realmax,1,3);

%specify which compare function we are using
cmp = @subimage_cityblock;

n = 7;
[imrows,imcols,~] = size(im);
nrows = imrows/n;
ncols = imcols/n;
for i=1:20:imrows-nrows
    for j=1:20:imcols-ncols
        %get subimage
        subimage = im(i:floor(i+nrows)-1,j:floor(j+ncols)-1,:);
        %calculate scores
        score_acmilan = [cmp(subimage,acmilan1),cmp(subimage,acmilan2),cmp(subimage,acmilan3)];
        score_barcelona = [cmp(subimage,barcelona1),cmp(subimage,barcelona2),cmp(subimage,barcelona3)];
        score_chelsea = [cmp(subimage,chelsea1),cmp(subimage,chelsea2),cmp(subimage,chelsea3)];
        score_juventus = [cmp(subimage,juventus1),cmp(subimage,juventus2),cmp(subimage,juventus3)];
        score_liverpool = [cmp(subimage,liverpool1),cmp(subimage,liverpool2),cmp(subimage,liverpool3)];
        score_madrid = [cmp(subimage,madrid1),cmp(subimage,madrid2),cmp(subimage,madrid3)];
        score_psv = [cmp(subimage,psv1),cmp(subimage,psv2),cmp(subimage,psv3)];

        s1 = min(s1,score_acmilan);
        s2 = min(s2,score_barcelona);
        s3 = min(s3,score_chelsea);
        s4 = min(s4,score_juventus);
        s5 = min(s5,score_liverpool);
        s6 = min(s6,score_madrid);
        s7 = min(s7,score_psv);
    end
end

%minimum = index with minimum value
[~,minimum] =  min([mean(s1),mean(s2),mean(s3),mean(s4),mean(s5),mean(s6),mean(s7)]);

if minimum == 1
    result = 'acmilan';
elseif minimum == 2
    result = 'barcelona';
elseif minimum == 3
    result = 'chelsea'; 
elseif minimum == 4
    result = 'juventus';
elseif minimum == 5
    result = 'liverpool';
elseif minimum == 6
    result = 'madrid';
elseif minimum == 7
    result = 'psv';
else
    result = 'error';
end
    


end