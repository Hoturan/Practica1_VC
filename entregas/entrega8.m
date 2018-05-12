%% Arnau Badia i David Williams
 im=imread('I:\vc\sample images\head.png');
 figure, imshow(im), title('imatge original')
 ero = imerode(im, strel('disk',1));
 cont = imsubtract(im,ero);
 figure, imshow(cont), title('contorn');

 area = sum(im(:));
 prm = sum(cont(:));
[fila, col] = find(cont,1);
B=bwtraceboundary(cont,[fila col],'E');
aux=zeros(size(cont));
aux(sub2ind(size(aux),B(:,1),B(:,2))) = 1;
figure, imshow(aux)
C(:,1) = B(1:end-1,1)-B(2:end,1);
C(:,2) = B(1:end-1,2)-B(2:end,2);
C(:,1) = C(:,1)+1;
C(:,2) = C(:,2)+1;

%signatura
sob = fspecial('sobel');
sobh=sob/4;
resh=imfilter(double(im),sobh,'conv');
resv=imfilter(double(im),sobh','conv');
alfa=atan2(resv,resh);
alfa2=uint8(255*(alfa+pi)/2/pi);
figure, imshow(alfa2)
slp=alfa2(sub2ind(size(alfa2),B(:,1),B(:,2)));
figure, plot(slp)
cdm = mean(B);
Bc = B-cdm;
s = Bc(:,1)+i*Bc(:,2);
z=fft(s);
figure, plot(abs(z))
figure, plot(log(abs(z)))
ss = ifft(z);
files = round(real(ss)+cdm(1));
cols = round(imag(ss)+cdm(2));
aux(:,:)=0;
aux(sub2ind(size(aux),files,cols))=1;
figure, imshow(aux), title('inversa fft') 
N=30;
tmp = z;
tmp(N+1:end-N)=0;
figure, plot(log(abs(tmp)))
ss2=ifft(tmp);
aux=logical(zeros(1000));
files=round(real(ss2)+500);

