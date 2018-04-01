function [score] = subimage_is_blaugrana5(im, model)
[rowsA colsB num] = size(im);
model = imresize(model,[rowsA colsB]);
hsv1 = rgb2hsv(im);
hsv2 = rgb2hsv(model);
DeltaE = sqrt(sum((hsv1 - hsv2) .^ 2))  ; % [EDITED, parentheses added]

if DeltaE < 0.5
    score = DeltaE;
else
    score = 0;
end
end
