function [score, value] = subimage_chisquared(im,mod)

nbins = 10;

nelem = numel(im)/3;
nelemmod = numel(mod)/3;


%histogrames normalitzats
r = imhist(im(:,:,1),nbins)./nelem;
g = imhist(im(:,:,2),nbins)./nelem;
b = imhist(im(:,:,3),nbins)./nelem;

modr = imhist(mod(:,:,1),nbins)./nelemmod;
modg = imhist(mod(:,:,2),nbins)./nelemmod;
modb = imhist(mod(:,:,3),nbins)./nelemmod;


r_diff = dist_chisq(r',modr');
g_diff = dist_chisq(g',modg');
b_diff = dist_chisq(b',modb');
value = mean([r_diff,g_diff,b_diff]);

score = value;

end