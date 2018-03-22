%% David Williams i Arnau Badia

%% Filtrat amb imfilter
im = ones(256);
im(1:128, 1:128) = 0;
im(129:256,129:256)=0;
figure, imshow(im);
res=zeros(256);
w=ones(31);
w=w/31/31;
res=imfilter(im,w,'conv','replicate');
figure, imshow(res);
%improfile
w= fspecial('gaussian',31);
figure, imshow(w);
w= fspecial('gaussian',31,6);
figure, imshow(w);
res=imfilter(im,w,'conv','replicate');
figure, imshow(res);
improfile
%% Filtrat amg gaussianes
clear all
im=imread('I:\vc\sample images\gull.tif');
figure,imshow(im)
imgauss=imnoise(im,'gaussian');
figure,imshow(imgauss);
w = fspecial('gaussian',7,2);
res = imfilter(double(imgauss),w,'conv', 'replicate');
figure,imshow(res, []);
imsp=imnoise(im,'salt & pepper',0.2);
figure, imshow(imsp)
res = imfilter(double(imsp),w,'conv', 'replicate');
figure,imshow(res, []);
res=medfilt2(imsp,[5,5]);
% Los claudators se ponen para que imshow coja como 0 el valor mas pequeño
% y como 1 el más grande de res
figure, imshow(res,[])
%% filtrado por gradiente
im = imread('I:\vc\sample images\rabbit.jpg');
figure, imshow(im)
w=fspecial('disk',2);
res = imfilter(double(im),w,'conv', 'replicate');
figure,imshow(res,[])
edges=imabsdiff(double(im),res);
figure,imshow(edges,[])
% gradient manual
Gx=double(im);
Gy=double(im);
Gx(:,2:end-1) = im(:,3:end) - im(:,1:end-2);
Gy(2:end-1,:) = im(3:end,:) - im(1:end-2,:);
G = sqrt(double(Gx.*Gx + Gy.*Gy));
figure,imshow(G,[]), title ('gradient manual')
% per convulció
w = [-1 0 1]
Gx = imfilter(double(im),w,'conv','replicate');
Gy = imfilter(double(im),w','conv','replicate');
mod=sqrt(Gx.*Gx+Gy.*Gy);
figure, imshow(abs(mod),[]), title('conv gradient')
% dividit per 4 per normalitzar
sobv=fspecial('sobel')/4
sobh=sobv';
Gx = imfilter(double(im),sobh,'conv','replicate');
Gy = imfilter(double(im),sobv,'conv','replicate');
mod=sqrt(Gx.*Gx+Gy.*Gy);
figure, imshow(abs(mod),[]), title('sobel')
arg=atan2(Gy,Gx);
arg=uint8(255*(arg+pi)/2/pi);
figure, imshow(arg),title('angle');
mask=mod<4;
aux=arg;
aux(mask)=0;
% crea una inconsitència amb els valors que tenen una orientació de 0
figure, imshow(aux),title('gradient orientation with mask');
%% Filtre laplacia
w = fspecial('laplacian');
lap = imfilter(double(im),w,'conv');
figure,imshow(lap,[]), title('laplacian filter')
profile = improfile
figure, plot(profile)



