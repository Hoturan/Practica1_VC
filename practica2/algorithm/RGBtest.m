im = imread('../models/acmilan/35.jpg');
figure, imshow(im)
nbins = 10;
nelem = numel(im)/3;

hist = imhist(im, nbins)./nelem;
figure, imshow(hist)

nelem = numel(im)/3;
[freq, freq_emphs, freq_ly] = image_hist_RGB_3d('../models/acmilan/35.jpg',nbins);

%%
mod = imread('../models/acmilan/35.jpg');
im = imread('../soccer/acmilan/01.jpg');
hist3(im)
%subimage_cityblock(im,mod)

%%
format longg;
format compact;
fontSize = 20;
rgbImage = imread('../models/acmilan/35.jpg');
% Get the dimensions of the image.  numberOfColorBands should be = 3.
[rows columns numberOfColorBands] = size(rgbImage);
% Display the original color image.
imshow(rgbImage);
title('Original Color Image', 'FontSize', fontSize);
% Enlarge figure to full screen.
set(gcf, 'units','normalized','outerposition',[0 0 1 1]);

% Extract the individual red, green, and blue color channels.
redChannel = rgbImage(:, :, 1);
greenChannel = rgbImage(:, :, 2);
blueChannel = rgbImage(:, :, 3);

% Construct the 3D color gamut (3D histogram).
gamut3D = zeros(256,256,256);
for column = 1: columns
	for row = 1 : rows
		rIndex = redChannel(row, column) + 1;
		gIndex = greenChannel(row, column) + 1;
		bIndex = blueChannel(row, column) + 1;
		gamut3D(rIndex, gIndex, bIndex) = gamut3D(rIndex, gIndex, bIndex) + 1;
	end
end

% Get a list of non-zero colors so we can put it into scatter3()
% so that we can visualize the colors that are present.
r = zeros(256, 1);
g = zeros(256, 1);
b = zeros(256, 1);
nonZeroPixel = 1;
for red = 1 : 256
	for green = 1: 256
		for blue = 1: 256
			if (gamut3D(red, green, blue) > 1)
				% Record the RGB position of the color.
				r(nonZeroPixel) = red;
				g(nonZeroPixel) = green;
				b(nonZeroPixel) = blue;
				nonZeroPixel = nonZeroPixel + 1;
			end
		end
	end
end
figure;
scatter3(r, g, b, 3);
xlabel('R', 'FontSize', fontSize);
ylabel('G', 'FontSize', fontSize);
zlabel('B', 'FontSize', fontSize);
msgbox('Click the rotation icon to change your point of view.');