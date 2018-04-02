function [score] = subimage_is_blaugrana5(im, model)

[rowsA colsB num] = size(im);
model_resize = imresize(model,[rowsA colsB]);
%figure,imshow(im2)
%figure,imshow(im3)
ssimval = ssim(im,model_resize);
if ssimval > 0.25
    score = ssimval*10;
else 
    score = 0;
end
end
