function [score] = subimage_is_blaugrana(im)

nbins = 3;
k = 1.6;

h_red = imhist(im(:,:,1),nbins);
h_green = imhist(im(:,:,2),nbins); 
h_blue = imhist(im(:,:,3),nbins);

if h_red(end) > k*h_green(end) && h_blue(end) > k*h_green(end)
    score = 1;
else 
    score = 0;
end
    
end