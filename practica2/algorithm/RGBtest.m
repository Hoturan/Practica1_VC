im = imread('../models/acmilan/35.jpg');
hist = imhist(im(:,:,1))
nbins = 20;

nelem = numel(im)/3;
[freq, freq_emph, freq_ly] = image_hist_RGB_3d('../models/acmilan/35.jpg',6);

