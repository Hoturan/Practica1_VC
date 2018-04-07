function [result] = get_score_chisquared(im)

im = histeq(im);
mod = histeq(imread('../models/29.jpg'));
n = 7;
%at the moment, the score just counts how how many subimages are considered
%to be blaugrana
score = 100000;
[nrows,ncols,~] = size(im);
rows = floor(nrows/n);
cols = floor(ncols/n);
for i=1:20:nrows-rows
    for j=1:20:ncols-cols
        subimage = im(i:i+rows-1,j:j+cols-1,:);
        score_subimage = subimage_chisquared(subimage,mod);
        if score_subimage < score   
            score = score_subimage;
        end
    end
end

result = score;


end