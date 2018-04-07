function [result] = get_score_chisquared(im)

global mod1 mod2 mod3 mod4 mod5 mod6 
im = histeq(im);
n = 7;
%at the moment, the score just counts how how many subimages are considered
%to be blaugrana
score1 = 100000;
score2 = 100000;
score3 = 100000;
score4 = 100000;
score5 = 100000;
score6 = 100000;
[nrows,ncols,~] = size(im);
rows = floor(nrows/n);
cols = floor(ncols/n);
for i=1:20:nrows-rows
    for j=1:20:ncols-cols
        subimage = im(i:i+rows-1,j:j+cols-1,:);
        score_subimage1 = subimage_chisquared(histeq(subimage,imhist(mod1)),mod1);
        score_subimage2 = subimage_chisquared(histeq(subimage,imhist(mod2)),mod2);
        score_subimage3 = subimage_chisquared(histeq(subimage,imhist(mod3)),mod3);
        score_subimage4 = subimage_chisquared(histeq(subimage,imhist(mod4)),mod4);
        score_subimage5 = subimage_chisquared(histeq(subimage,imhist(mod5)),mod5);
        score_subimage6 = subimage_chisquared(histeq(subimage,imhist(mod6)),mod6);
        %score_subimage = score_subimage1 + score_subimage2 + score_subimage3 + score_subimage4 + score_subimage5 + score_subimage6;
        %score_subimage = min(score_subimage);
        if score_subimage1 < score1   
           score1 = score_subimage1;
        end
        if score_subimage2 < score2   
            score2 = score_subimage2;
        end
        if score_subimage3 < score3   
            score3 = score_subimage3;
        end
        if score_subimage4 < score4   
           score4 = score_subimage4;
        end
        if score_subimage5 < score5   
            score5 = score_subimage5;
        end
        if score_subimage6 < score6   
           score6 = score_subimage6;
        end
    end
end

result =  score2 + score3 + score5 + score1 + score4 + score6;
result = result /2;

end