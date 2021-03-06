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
im = imread('soccer/barcelona/03.jpg');
n = 3;
nbins = 50;
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
        figure
        subplot(3,1,1), imhist(im(row_index:row_index+nrows-1,col_index:col_index+ncols-1,1),nbins), title(['row: ',num2str(i),' col: ',num2str(j),' R']) 
        subplot(3,1,2), imhist(im(row_index:row_index+nrows-1,col_index:col_index+ncols-1,2),nbins), title(['row: ',num2str(i),' col: ',num2str(j),' G']) 
        subplot(3,1,3), imhist(im(row_index:row_index+nrows-1,col_index:col_index+ncols-1,3),nbins), title(['row: ',num2str(i),' col: ',num2str(j),' B'])
        if (i == 2 && j == 2)
            imModel = im(row_index:row_index+nrows-1,col_index:col_index+ncols-1,:);
        end
        %segmenting the original image by subimages
        imseg(row_index,:,:) = 255;
        imseg(:,col_index,:) = 255;
    end
end

%shows segmented image
figure, imshow(imseg);

%Selected segment to use as model
figure, imshow(imModel)

%% Color plot of the whole image without segmentation

imRed = im(:,:,1);
imGreen = im(:,:,2);
imBlue = im(:,:,3);

[yRed] = imhist(imRed);
[yGreen] = imhist(imGreen);
[yBlue, x] = imhist(imBlue);

figure, plot (x, yRed, 'Red', x, yGreen, 'Green', x, yBlue, 'Blue'), title('RGB plot');

%% Normalize ilumination of an Image

im = imread('soccer/barcelona/03.jpg');
figure, imshow(im), title('Model Image');
im2 = imread('soccer/barcelona/02.jpg');
figure, imshow(im2), title('Image to normalize');

% Enhance contrast using histogram equalization
im2norm = histeq(im2,imhist(im));
figure, imshow(im2norm), title('Image normalized');

%% try function
im = imread('soccer/barcelona/03.jpg');
[imS, Model] = segment(im, 3, 2, 2);
figure, imshow(imS)
figure, imshow(Model)

%% Pairwise Distance
im = imread('model1.jpg');
im2o = imread('soccer/barcelona/03.jpg');
[akhbs, im2] = segment(im2o, 3, 2, 2);
[rowsA colsB num] = size(im2);
im3 = imresize(im,[rowsA colsB]);
figure,imshow(im2)
figure,imshow(im3)
ssimval = ssim(im2,im3)
%C = normxcorr2(Model,im2);
%% new
im = imread('soccer/barcelona/03.jpg');
im2 = imread('modelo1.png');
[rowsA colsB num] = size(im);
im3 = imresize(im2,[rowsA colsB]);
absDiffImage = psnr(im3, im)
%% new 2
i1 = imread('soccer/barcelona/03.jpg');
i2 = imread('soccer/barcelona/03.jpg');
i1=i1(:,:,1);
[c1,n]=imhist(i1);
c1=c1/size(i1,1)/size(i1,2);
i2=i2(:,:,1);
[c2,n2]=imhist(i2);
c2=c2/size(i2,1)/size(i2,2);
d=pdist2(c1',c2')