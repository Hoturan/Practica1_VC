%% David Williams i Arnau Badia
%% histogrames
im=imread('I:\vc\sample images\Que_es.png');
h = histograma(im);
%histograma
figure, bar(h);
minval = min(min(im));
maxval = max(max(im));
im2 = (im-minval)*(255/(maxval-minval));
h2=imhist(im2);
%histograma equalitzat
figure, bar(h2), title('histrograma');
%histograma amb imhist
h3 = imhist(im);
figure,bar(h3), title('imhist');
%% imatge negada
neg = 255 - im;
figure,imshow(neg),title('negada');

neg2 = imcomplement(im2);
figure, imshow(neg2), title('equalitzada negada');

%% operancions aritmetiques
im1 = imread('I:\vc\sample images\toycars1.png');
im2 = imread('I:\vc\sample images\toycars2.png');
im3 = imread('I:\vc\sample images\toycars3.png');
figure, subplot(1,3,1),imshow(im1)
subplot(1,3,2), imshow(im2)
subplot(1,3,3), imshow(im3)

figure, subplot(1,2,1),imshow(im1-im2), title('im1 - im2')
subplot(1,2,2), imshow(im2-im3), title('im2 - im3')

%imatge diferencia absoluta
figure, imshow(imabsdiff(im1,im2)), title('diferencies de valor absolut')
% fet de forma manual
figure, imshow(abs(im1-im2)+abs(im2-im1))

%% Suavitzat
im = ones(256);
im(1:128, 1:128) = 0;
im(129:256,129:256)=0;
figure, imshow(im), title('imatge original')
figure, surf(im)
% convulucions
im_res = im;
% sumamos el pixel izquierdo
im_res(:,2:end) = im_res(:,2:end) + im(:,1:end-1);
% sumamos el pixel derecho
im_res(:,1:end-1) = im_res(:,1:end-1) + im(:,2:end);
% sumamos el pixel de arriba
im_res(2:end,:) = im_res(2:end,:) + im(1:end-1,:);
% sumamos el pixel de abajo
im_res(1:end-1,:) = im_res(1:end-1,:) + im(2:end,:);
%normalizamos
im_res = im_res /5;
figure, imshow(im_res), title('imatge suavitzat')


