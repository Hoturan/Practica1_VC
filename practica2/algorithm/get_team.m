function [result] = get_team(im)

global acmilan barcelona chelsea juventus liverpool madrid psv 

score1 = realmax;
score2 = realmax;
score3 = realmax;
score4 = realmax;
score5 = realmax;
score6 = realmax;
score7 = realmax;

%specify which compare function we are using
compare_function = @subimage_cityblock;

n = 7;
[imrows,imcols,~] = size(im);
nrows = imrows/n;
ncols = imcols/n;
for i=1:20:imrows-nrows
    for j=1:20:imcols-ncols
        %get subimage
        subimage = im(i:floor(i+nrows)-1,j:floor(j+ncols)-1,:);
        %calculate scores
        score_subimage1 = compare_function(subimage,acmilan);
        score_subimage2 = compare_function(subimage,barcelona);
        score_subimage3 = compare_function(subimage,chelsea);
        score_subimage4 = compare_function(subimage,juventus);
        score_subimage5 = compare_function(subimage,liverpool);
        score_subimage6 = compare_function(subimage,madrid);
        score_subimage7 = compare_function(subimage,psv);
        %if the score_subimage is less than the existing one set the score
        %to score_subimage
        score1 = min(score1,score_subimage1);
        score2 = min(score2,score_subimage2);
        score3 = min(score3,score_subimage3);
        score4 = min(score4,score_subimage4);
        score5 = min(score5,score_subimage5);
        score6 = min(score6,score_subimage6);
        score7 = min(score7,score_subimage7);
    end
end

minimum =  min([score1,score2,score3,score4,score5,score6,score7]);

if minimum == score1
    result = 'acmilan';
elseif minimum == score2
    result = 'barcelona';
elseif minimum == score3
    result = 'chelsea'; 
elseif minimum == score4
    result = 'juventus';
elseif minimum == score5
    result = 'liverpool';
elseif minimum == score6
    result = 'madrid';
elseif minimum == score7
    result = 'psv';
else
    result = 'error';
end
    


end