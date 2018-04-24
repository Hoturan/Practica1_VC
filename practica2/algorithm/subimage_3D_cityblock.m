function [score, value] = subimage_3D_cityblock(im,mod)

nbins = 5;

nelem = numel(im)/3;
nelemmod = numel(mod)/3;


%histogrames normalitzats
%r = imhist(im(:,:,1),nbins)./nelem;
% = imhist(im(:,:,2),nbins)./nelem;
%b = imhist(im(:,:,3),nbins)./nelem;
[freq] = image_hist_RGB_3d(im,nbins);
[freqm] = image_hist_RGB_3d(mod,nbins);

freq2d = reshape(freq, nbins*nbins*nbins,1)./nelem;
freq2dm = reshape(freqm, nbins*nbins*nbins,1)./nelemmod;
%modr = imhist(mod(:,:,1),nbins)./nelemmod;
%modg = imhist(mod(:,:,2),nbins)./nelemmod;
%modb = imhist(mod(:,:,3),nbins)./nelemmod;


%r_diff = pdist2(r',modr','cityblock');
%g_diff = pdist2(g',modg','cityblock');
%b_diff = pdist2(b',modb','cityblock');
diff = pdist2(freq2d', freq2dm', 'cityblock');
value = mean(diff);

score = value;