function [score, value] = subimage_cityblock(im,mod)

nbins = 20;

nelem = numel(im)/3;
nelemmod = numel(mod)/3;


%histogrames normalitzats
r = imhist(im(:,:,1),nbins)./nelem;
g = imhist(im(:,:,2),nbins)./nelem;
b = imhist(im(:,:,3),nbins)./nelem;

modr = imhist(mod(:,:,1),nbins)./nelemmod;
modg = imhist(mod(:,:,2),nbins)./nelemmod;
modb = imhist(mod(:,:,3),nbins)./nelemmod;


r_diff = pdist2(r',modr','cityblock');
g_diff = pdist2(g',modg','cityblock');
b_diff = pdist2(b',modb','cityblock');
value = mean([r_diff,g_diff,b_diff]);


score = value;