function [score] = subimage_is_blaugrana2(im)

[r,c,p] = size(im);
n_elem = r*c;

k = 1.5;
k2 = 3;
count_red = 0;
count_blue = 0;

for i=1:r
    for j=1:c
        if (im(i,j,1) > k*max(im(i,j,2),im(i,j,3)))
            count_red = count_red + 1;
             if (im(i,j,3) > k2*max(im(i,j,1),im(i,j,2)))
                count_blue = count_blue + 10;
            end
        end
        if (im(i,j,3) > k*max(im(i,j,1),im(i,j,2)))
            count_blue = count_blue + 1;
            if (im(i,j,3) > k2*max(im(i,j,1),im(i,j,2)))
                count_blue = count_blue + 10;
            end
        end
    end
end

if min(count_red,count_blue) > 0.2*n_elem
    score = min(count_red,count_blue)/n_elem;
else   
    score = 0;
end
