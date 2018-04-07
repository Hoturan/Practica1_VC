function [score, value] = subimage_is_blaugrana6(im,mod)

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

% 
% dr = dist_chisq(r',modr');
% dg = dist_chisq(g',modg');
% db = dist_chisq(b',modb');
% 
% value = max([dr,dg,db]);





%cacular mitja de cada histograma
% mean_r = sum(r.*[1:10]')/sum(r);
% mean_g = sum(g.*[1:10]')/sum(g);
% mean_b = sum(b.*[1:10]')/sum(b);

% mean_modr = sum(modr.*[1:10]')/sum(modr);
% mean_modg = sum(modg.*[1:10]')/sum(modg);
% mean_modb = sum(modb.*[1:10]')/sum(modb);
% 
% 
% value = max(abs([mean_r,mean_g,mean_b]-[mean_modr,mean_modg,mean_modb]));


r_diff = pdist2(r',modr','cityblock');
g_diff = pdist2(g',modg','cityblock');
b_diff = pdist2(b',modb','cityblock');
value = mean([r_diff,g_diff,b_diff]);


score = value;

% if  value < 0.05
%     score = 1;
% else
%     score = 0;
% end

end
