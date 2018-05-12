%% David Williams & Arnau Badia
%%Dilate & erode
im=imread('I:\vc\sample images\scissors.tif');
figure, imshow(im), title('imatge scissors')
ee=ones(3);
dil=imdilate(im,ee);
figure, imshow(dil), title('imatge dilatada')
se = strel('disk',5);
dil=imdilate(im,se);
figure, imshow(dil), title('imatge dilatada disk radi 5')
ero=imerode(im,se);
figure, imshow(ero), title('imatge erosionada disk radi 5')

%% Open & close
im=imread('I:\vc\sample images\blob.tif');
figure, imshow(im), title('imatge original');
%can be done with imopen and imclose
op=imdilate(imerode(im,se),se);
figure, imshow(op), title('open');

cl=imerode(imdilate(im,se),se);
figure, imshow(cl), title('close');

%% Residue
im=imread('I:\vc\sample images\blob3.tif');
figure, imshow(im), title('imatge original')
se=strel('disk',1);

dil = imdilate(im,se);
ce = imsubtract(dil,im);
figure,imshow(ce),title('contorn extern')
ero = imerode(im,se);
ci=imsubtract(im,ero);
figure,imshow(ci),title('contorn intern')

lap=imsubtract(double(ce),double(ci));
figure,imshow(lap,[]),title('laplacia')

%% Disk labeling
im=imread('I:\vc\sample images\gear.tif');
figure, imshow(im), title('imatge original')
% Obliga a que se sea lo mas circular possible sin hacer optimizaciones
se=strel('disk',20,0);
ero = imopen(im,se);
figure,imshow(ero),title('erode')
di = im-ero;
eti = bwlabel(di,4);
figure, imshow(eti), title('imatge etiquetada')

%% Conditional dilatation
im=imread('I:\vc\sample images\blob3.tif');
figure, imshow(im), title('imatge original')
marc=ones(size(im));
marc(2:end-1, 2:end-1)=0;
se=strel('disk',1);
dil=imdilate(marc,se);
dilc = dil&im;
figure, imshow(dilc)
dilc=imdilate(dilc,se)&im;
dilc=imdilate(dilc,se)&im;
dilc=imdilate(dilc,se)&im;
dilc=imdilate(dilc,se)&im;
dilc=imdilate(dilc,se)&im;
dilc=imdilate(dilc,se)&im;
figure, imshow(dilc)
rec=imreconstruct(marc,double(im));
figure, imshow(rec), title('reconstruccio')
res = imsubtract(double(im),rec);
figure, imshow(res), title('sense vores')

%% Reconstruction
im=imread('I:\vc\sample images\pcbholes.tif');
figure, imshow(im), title('imatge original')
se=strel('disk',5);
dil = imdilate(im,se);
nim = imcomplement(im);
marc=ones(size(nim));
marc(2:end-1, 2:end-1)=0;
rec=imreconstruct(marc,double(nim));
figure, imshow(rec), title('reconstruccio')
noa = imcomplement(rec);
res =  noa -im;
figure, imshow(res), title('resultat')

%% 
im=imread('I:\vc\sample images\letters.tif');
figure, imshow(im), title('imatge original')
marc=ones(size(im));
marc(2:end-1, 2:end-1)=0;
rec=imreconstruct(marc,double(im));
res = imsubtract(double(im),rec);
figure, imshow(res), title('sense vores')

se = strel('line',15,90);
mark = imerode(res, se);
figure, imshow(mark), title('marques')
rec=imreconstruct(mark, res);
figure, imshow(rec), title('reconstruction')

%%
im= imread('I:\vc\sample images\tools.tif');
figure, imshow(im), title('imatge original')
figure,imshow(im)
mark=imerode(im,strel('disk',7));
figure,imshow(mark),title('marques');
rec = imreconstruct(mark,im);
figure,imshow(rec),title('reconstruccio')
bw=bwareaopen(im,1200);
figure,imshow(bw),title('Area open')

im= imread('I:\vc\sample images\touchcell.tif');
figure, imshow(im), title('imatge original')
dist=bwdist(~im);
figure, imshow(dist), title('T de distancia')
figure, imshow(dist, []), title('T de distancia')
figure, surf(dist)