function [] = create_segmented_image_histogram(im_name,n,nbins)


%{
figure,imshow(im);
figure,imhist(im);
im2 = imread('soccer/barcelona/02.jpg');
figure,imshow(im2);
figure,imhist(im2);
im3 = imread('soccer/barcelona/03.jpg');
figure,imshow(im3);
figure,imhist(im3);
im4 = imread('soccer/barcelona/04.jpg');
figure,imshow(im4);
figure,imhist(im4);
im5 = imread('soccer/barcelona/05.jpg');
figure,imshow(im5);
figure,imhist(im5);
im = im3;
%}


% Takes image im, divides it into n*n subimages, and shows an histogram for 
% each component (RGB). Lastly, it shows the original image divided by
% subimages
im = imread(im_name);
im = histeq(im);
%weird matlab
[nrows,ncols,p] = size(im);
%this could be done in a more exact way, but if n is not very large it is
%not an issue
nrows = floor(nrows/n);
ncols = floor(ncols/n);
% segmented image
imseg = im;

for i=1:n
    for j=1:n
        %array indexing in matlab is painful. 
        %e.g A = [2,4,5,6,7,8]... -> A(2:4) returns (4,5,6)
        row_index = 1 + (i-1)*nrows;
        col_index = 1 + (j-1)*ncols;
        r = im(row_index:row_index+nrows-1,col_index:col_index+ncols-1,1);
        g = im(row_index:row_index+nrows-1,col_index:col_index+ncols-1,2);
        b = im(row_index:row_index+nrows-1,col_index:col_index+ncols-1,3);
        s = subimage_is_blaugrana(im(row_index:row_index+nrows-1,col_index:col_index+ncols-1,:));
        if s > 0.2
            fprintf('row %d, col %d:  %f...\n',i,j,s);
        end
        figure
        subplot(3,1,1), bar(imhist(r,nbins)), title(['row: ',num2str(i),' col: ',num2str(j),' R -> score: ',s]) 
        subplot(3,1,2), bar(imhist(g,nbins)), title(['row: ',num2str(i),' col: ',num2str(j),' G -> score: ',s]) 
        subplot(3,1,3), bar(imhist(b,nbins)), title(['row: ',num2str(i),' col: ',num2str(j),' B -> score: ',s])
        %segmenting the original image by subimages
        imseg(row_index,:,:) = 255;
        imseg(:,col_index,:) = 255;
    end
end

%shows segmented image
figure, imshow(imseg);
