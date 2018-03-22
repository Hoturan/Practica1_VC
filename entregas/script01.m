%-- 01/03/2018 8:11 --%
%% Informe de la sessió 1
clear all
close all
I=imread('Floppy.bmp');
imshow(I)
impixelinfo
colormap jet
colormap hot
impixelinfo
imshow(I)
% el colormap no ha funcionat
colormap jet
impixelinfo
colorbar
imshow(I, jet)
I=imread('Floppy.bmp');
imshow(I)
imshow(I, jet)
I=imread('Floppy.bmp');
imshow(I)
colorbar
impixelinfo
improfile
[rows cols]=size(I)
%% Acces als pixels de la matriu
I=imread('Floppy.bmp');
imshow(I)
colorbar
improfile
I(55,75)
I(55:60)
I(55:60,75:80)
figure
figure,imshow(I)
figure
subplot(1,2,1);imshow(I);
subplot(1,2,1);imagesc(I);
subplot(1,2,1);imshow(I);
subplot(1,2,2);imagesc(I);
axis image;
image
subplot(1,2,1);imshow(I);
subplot(1,2,2);imagesc(I);
axis image;
image
axis off
%% G'day Mate
B=rand(256).*1000;
figure, imshow(B)
figure, subplot(1,2,1),imshow(B,[0 1000])
subplot(1,2,2),imshow(B,[])
figure,surf(I)