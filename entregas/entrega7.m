%% David Williams & Arnau Badia
im=imread('I:\vc\sample images\n2538.tif');
figure, imshow(im), title('imatge original')
ee = strel('disk', 3);
dil = imdilate(im,ee);
ero = imerode(im, ee);
op = imopen(im,ee);
cl = imclose(im,ee);
figure, imshow(dil), title('dilate')
figure, imshow(ero), title('erosio')
figure, imshow(op), title('open')
figure, imshow(op), title('close')
close all

%% Gradient morfologic
im=imread('I:\vc\sample images\danaus.tif');
figure, imshow(im), title('imatge original')
ee = strel('disk', 1);
dil = imdilate(im, ee);
ero = imerode(im, ee);
edge = imsubtract(dil, ero);
figure, imshow(edge), title('gradient morfologic')

%% Detectar petites estructures
im = imread('I:\vc\sample images\nshadow.tif');
figure, imshow(im), title('Imatge originial')
ee = strel('disk',5);
th=imtophat(im,ee);
figure, imshow(th, [])

%% Eliminació de soroll
im = imread('I:\vc\sample images\Birds.tif');
figure, imshow(im), title('Imatge originial')
ee = strel('disk', 1);
op = imopen(im,ee);
figure, imshow(op), title('Imatge sense ratlles blanques')
cl = imclose(op, ee);
figure, imshow(cl), title('Imatge sense ratlles')

%% detectar defectes en televisions de tubs catòdics
im = imread('I:\vc\sample images\r4x2_256.tif');
figure, imshow(im), title('imtage original')
se = strel('line', 40,90);
bh = imbothat(im,se);
%imbothat és equivalent a fer un close i restar-lo de la imatge original:
%cl = imclose(im,se);
%dif = imsubtract(cl, im);
figure, imshow(bh), title('imbothat')
bw = im2bw(bh,0.2);
figure, imshow(bw), title('imbothat & im2bw')
res = bwareaopen(bw,10);
figure, imshow(res)

%% Aspirines
im = imread('I:\vc\sample images\astablet.tif');
figure, imshow(im), title('imatge original aspirines')
rm = imregionalmax(im);
figure, imshow(rm)
%bw = im2bw(imdilate(imopen(im,strel('disk',3)),strel('disk',3)),0.8);
ee=strel('disk',20,0);
op=imopen(im,ee);
figure,imshow(op),title('open')
rm = imregionalmax(op);
figure, imshow(rm), title('regional max')
close all
%% 
im = imread('I:\vc\sample images\rabbit.jpg');
ee = strel('disk', 1);
grad = imsubtract(imdilate(im,ee), imerode(im,ee));
figure, imshow(grad), title('gradient')
figure, surf(grad)
segm = watershed(grad);
figure, imshow(segm,[]), title('watershed')
figure, imshow(segm==0)
rm = imregionalmin(grad);
figure, imshow(rm)
rm2 = imextendedmin(grad,5);
figure, imshow(rm2), title('rm2')
ee = strel('disk', 1);
rm2 = imopen(rm2,ee);
figure, imshow(rm2), title('minims h>5')
grad2 = imimposemin(grad, rm2);
segm2 = watershed(grad2);
figure, imshow(segm2), title('watershed amb markers')
figure, surf(segm2)
figure, imshow(segm2==0)

