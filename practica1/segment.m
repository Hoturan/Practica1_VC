function [imSegment, imModel] = segment (im, n, iM, jM)

[nrows,ncols,~] = size(im);
%this could be done in a more exact way, but if n is not very large it is
%not an issue
nrows = floor(nrows/n);
ncols = floor(ncols/n);
% segmented image
imSegment = im;

for i=1:n
    for j=1:n
        %array indexing in matlab is painful. 
        %e.g A = [2,4,5,6,7,8]... -> A(2:4) returns (4,5,6)
        row_index = 1 + (i-1)*nrows;
        col_index = 1 + (j-1)*ncols;
        %figure
        %subplot(3,1,1), imhist(im(row_index:row_index+nrows-1,col_index:col_index+ncols-1,1),nbins), title(['row: ',num2str(i),' col: ',num2str(j),' R']) 
        %subplot(3,1,2), imhist(im(row_index:row_index+nrows-1,col_index:col_index+ncols-1,2),nbins), title(['row: ',num2str(i),' col: ',num2str(j),' G']) 
        %subplot(3,1,3), imhist(im(row_index:row_index+nrows-1,col_index:col_index+ncols-1,3),nbins), title(['row: ',num2str(i),' col: ',num2str(j),' B'])
        if (i == iM && j == jM)
            imModel = im(row_index:row_index+nrows-1,col_index:col_index+ncols-1,:);
        end
        %segmenting the original image by subimages
        imSegment(row_index,:,:) = 255;
        imSegment(:,col_index,:) = 255;
    end
end

end