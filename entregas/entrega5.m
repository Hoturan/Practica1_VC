%% David Williams & Arnau Badia
%% Segmentacion region growing
global im eti TH MAXFILA MAXCOL

im=imread('I:\vc\sample images\Ipces01.tif');
figure,imshow(im), title('Ipces01')
hsv=rgb2hsv(im);
h=hsv(:,:,1);
figure,imshow(h), title('hue')
figure, plot(imhist(h))

im = int16(im);

[MAXFILA, MAXCOL, nchan] = size(im);
TH = 20;
eti=zeros(MAXFILA,MAXCOL);
RG(18,252,1);
figure, imshow(eti), title('First version of RG')

eti=zeros(MAXFILA,MAXCOL);
RG_llavor(18,252,1);
figure, imshow(eti), title('Second version of RG')


%% K-Means Clustering
im=imread('I:\vc\sample images\peppers.png');

figure, imshow(im), title('peppers')
[MAXFILA, MAXCOL, nchan] = size(im);
hsv = rgb2hsv(im);
hs=hsv(:,:,1:2);
k=3;
vect=reshape(hs,MAXFILA*MAXCOL,2);
[cl_lable, cl_center] = kmeans(vect,k,'distance','cityblock');
cl_center
eti=reshape(cl_lable,MAXFILA,MAXCOL);
figure,imshow(eti,[]);

