function [result] = image_is_fcb(im)

im = histeq(im);
n =  10;
score_threshold = 1.3;
%at the moment, the score just counts how how many subimages are considered
%to be blaugrana
score = 0;

[nrows,ncols,~] = size(im);
nrows = floor(nrows/n);
ncols = floor(ncols/n);
for i=1:n
    for j=1:n
        %array indexing in matlab is painful. 
        %e.g A = [2,4,5,6,7,8]... -> A(2:4) returns (4,5,6)
        row_index = 1 + (i-1)*nrows;
        col_index = 1 + (j-1)*ncols;
        subimage = im(row_index:row_index+nrows-1,col_index:col_index+ncols-1,:);
        score_subimage = subimage_is_blaugrana2(subimage);
        %if score_subimage > 0.2
        %    fprintf('row %d, col %d:  %f...\n',i,j,score_subimage);
        score = score + score_subimage;
            %fprintf('row %d, col: is blaugrana\n',i,j);
    end
end

%if the number of blaugrana images is more than a number, we say that the
%image is from fcb players
if score > score_threshold
    result = true;
else
    result = false;
end

end