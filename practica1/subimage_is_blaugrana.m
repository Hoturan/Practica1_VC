function [score] = subimage_is_blaugrana(im)

im = histeq(im);
nbins = 3;
k = 9;

h_red = imhist(im(:,:,1),nbins);
h_green = imhist(im(:,:,2),nbins); 
h_blue = imhist(im(:,:,3),nbins);

r = h_red(end);
g = h_green(end);
b = h_blue(end);

if min(r,b) > k*g && abs(1-r/b) < 0.5
    score = min(r,b)/(g+5);
    if score > 5
        score = score * 3;
    end
else 
    score = 0;
end

end