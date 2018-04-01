function [score] = subimage_is_blaugrana4(im, model)

i1 = im;
i2 = model;
i1=i1(:,:,1);
[c1,n]=imhist(i1);
c1=c1/size(i1,1)/size(i1,2);
i2=i2(:,:,1);
[c2,n2]=imhist(i2);
c2=c2/size(i2,1)/size(i2,2);
d=pdist2(c1',c2');

if d < 0.10
    score = 0.02/d;
else
    score = 0;
end
end
