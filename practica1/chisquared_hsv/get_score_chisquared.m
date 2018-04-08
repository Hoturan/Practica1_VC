function [result] = get_score_chisquared(im)

global mod1 mod2 mod3 mod4 mod5 mod6 

im = rgb2hsv(im);

score1 = realmax;
score2 = realmax;
score3 = realmax;
score4 = realmax;
score5 = realmax;
score6 = realmax;

n = 7;
[imrows,imcols,~] = size(im);
nrows = imrows/n;
ncols = imcols/n;
for i=1:20:imrows-nrows
    for j=1:20:imcols-ncols
        %get subimage
        subimage = im(i:floor(i+nrows)-1,j:floor(j+ncols)-1,:);
        %calculate scores
        score_subimage1 = subimage_chisquared(histeq(subimage,imhist(mod1)),mod1);
        score_subimage2 = subimage_chisquared(histeq(subimage,imhist(mod2)),mod2);
        score_subimage3 = subimage_chisquared(histeq(subimage,imhist(mod3)),mod3);
        score_subimage4 = subimage_chisquared(histeq(subimage,imhist(mod4)),mod4);
        score_subimage5 = subimage_chisquared(histeq(subimage,imhist(mod5)),mod5);
        score_subimage6 = subimage_chisquared(histeq(subimage,imhist(mod6)),mod6);
        %if the score_subimage is less than the existing one set the score
        %to score_subimage
        score1 = min(score1,score_subimage1);
        score2 = min(score2,score_subimage2);
        score3 = min(score3,score_subimage3);
        score4 = min(score4,score_subimage4);
        score5 = min(score5,score_subimage5);
        score6 = min(score6,score_subimage6);
    end
end

result =  mean([score1,score2,score3,score4,score5,score6]);
end