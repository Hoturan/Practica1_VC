function [score] = subimage_is_blaugrana3(im, im2)


% Get means of first image
meanRed1 = mean2(im(:,:,1));
meanGreen1 = mean2(im(:,:,2));
meanBlue1 = mean2(im(:,:,3));
% Get means of second image
meanRed2 = mean2(im2(:,:,1));
meanGreen2 = mean2(im2(:,:,2));
meanBlue2 = mean2(im2(:,:,3));

deltaR = abs(double(meanRed2) - double(meanRed1));
deltaG = abs(double(meanGreen2) - double(meanGreen1));
deltaB = abs(double(meanBlue2) - double(meanBlue1));

if deltaR < 18 && deltaG < 18 && deltaB < 18
    score = 50/(deltaR + deltaG + deltaB);
else
    score = 0;
end

end
