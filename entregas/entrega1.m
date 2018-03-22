im=imread('flowers.tif');
figure, imshow(im)
impixelinfo
r=im(:,:,1);
g=im(:,:,2);
b=im(:,:,3);
figure,imshow(r),title('component R')
figure,imshow(b),title('component B')
figure,imshow(g),title('component G')
rgb=cat(3,r,g,b);
figure,imshow(rgb),title('components ajustades')
rgb=cat(3,g,b,r);
gbr=cat(3,g,b,r);
rgb=cat(3,r,g,b);
figure,imshow(gbr),title('components mal ajustades')
gris=rgb2gray(im);
figure,imshow(gris), title('imatge greylevel')
cmy=imcomplement(im);
figure,imshow(cmy), title('imatge complement')
hsv=rgb2hsv(im);
figure,imshow(hsv(:,:,1)), title('hue')
figure,imshow(hsv(:,:,2)), title('sat')
%% rgb normalized
rnorm = double(r) ./ double(r+g+b);
gnorm = double(g) ./ double(r+g+b);
bnorm = double(b) ./ double(r+g+b);
figure,imshow(cat(3,rnorm,gnorm,bnorm)), title('rgb norm')
%% hsv normalized
hsv=rgb2hsv(im);
figure,imshow(hsv);
hsv(:,:,3) = 0.5;
im2 = hsv2rgb(hsv);
figure,imshow(im2),title('hsv norm')