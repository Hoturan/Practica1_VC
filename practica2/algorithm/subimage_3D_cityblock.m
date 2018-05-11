function [distance] = subimage_3D_cityblock(im,mod)

nbins = 5;

nelem = numel(im)/3;
nelemmod = numel(mod)/3;


%histogrames normalitzats
%r = imhist(im(:,:,1),nbins)./nelem;
% = imhist(im(:,:,2),nbins)./nelem;
%b = imhist(im(:,:,3),nbins)./nelem;
[freq] = image_hist_RGB_3d(im,nbins);
[freqm] = image_hist_RGB_3d(mod,nbins);

%flatten matrix and normalize
freq = reshape(freq,1,nbins^3)./nelem;
freqm = reshape(freqm,1,nbins^3)./nelemmod;

distance = dist_chisq(freq, freqm);
