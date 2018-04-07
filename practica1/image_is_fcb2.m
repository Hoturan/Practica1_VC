function [result] = image_is_fcb2(im)

im = histeq(im);
%mod = imread('modelmaxi.png');
mod = histeq(imread('models/29.jpg'));
n = 7;
%at the moment, the score just counts how how many subimages are considered
%to be blaugrana
score = 100000;
[nrows,ncols,~] = size(im);
rows = floor(nrows/n);
cols = floor(ncols/n);
for i=1:20:nrows-rows
    for j=1:20:ncols-cols
        %array indexing in matlab is painful. 
        %e.g A = [2,4,5,6,7,8]... -> A(2:4) returns (4,5,6)
        subimage = im(i:i+rows-1,j:j+cols-1,:);
        
        score_subimage = subimage_is_blaugrana6(subimage,mod);
        %if score_subimage > 0.2
        %    fprintf('row %d, col %d:  %f...\n',i,j,score_subimage);
        if score_subimage < score
            
            score = score_subimage;
        end
            
            %fprintf('row %d, col: is blaugrana\n',i,j);
    end
end

%if the number of blaugrana images is more than a number, we say that the
%image is from fcb players

result = score;

% if score > score_threshold
%     result = true;
% else
%     result = false;
% end

end