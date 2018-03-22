function [h]=histograma (im)

[files cols]=size(im);
h=zeros(256,1);
for i=1:files
    for j= 1:cols
        h(im(i,j)+1) = h(im(i,j)+1) + 1;
    end
end