function x = get_image_features(img,box_coord,contour)
 %figure, imshow(image)
%for a certain image, we must extract features
%this functions returns an array of features
    x = [];

    bb_hmin = box_coord(1);
    bb_hmax = box_coord(2);
    bb_wmin = box_coord(3);
    bb_wmax = box_coord(4);
    bbwidth = bb_wmax - bb_wmin;
    bbheight = bb_hmax - bb_hmin;
    c_x = contour(1,:);
    c_y = contour(2,:);
    
    %generate bw image
    bb_img = img(bb_hmin:bb_hmax,bb_wmin:bb_wmax);
    bw_img = roipoly(bb_img,c_x,c_y);
    
    %BOUNDING BOX AREA
    bb_area = bbheight*bbwidth;
    %ANIMAL AREA (bwarea returns area of white pixels)
    animal_area = bwarea(bw_img);

    

    
    %feature 1: rectangularity -> ratio between bb area and animal area
    rectangularity = animal_area / bb_area;
    x = [x,rectangularity];   
    
    %feature 2: ratio of compact area to animal area
    ee = strel('disk',10);
    compact_img = imopen(bw_img,ee);
    %to normalize
    compact_ratio = bwarea(compact_img)/animal_area;
    x = [x,compact_ratio];   

    %*********REGIONPROPS FEATURES*******************
    r = regionprops(bw_img,'MajorAxisLength','convexHull','Perimeter','Centroid','MinorAxisLength');
    
    %feature 3: major axis length
    max_major_axis_length = max([r.MajorAxisLength]);
    x = [x,max_major_axis_length];
    
    %feature 4: minor axis length
    max_minor_axis_length = max([r.MinorAxisLength]);
    x = [x,max_minor_axis_length];
    
    %feature 5: difference animal area vs convex hulls areas
    sum_convex_hulls_area = sum(cellfun(@(ch) polyarea(ch(:,1),ch(:,2)),{r.ConvexHull}));
    ratio_convex_hull_to_animal_areas = animal_area/sum_convex_hulls_area;
    x = [x,ratio_convex_hull_to_animal_areas];   

    %feature 6: compacity
    perimeter = sum([r.Perimeter]);
    compacity = perimeter^2/animal_area;
    x = [x,compacity];

    %feature 7: elongation
    elongation = max(bbheight,bbwidth)/min(bbheight,bbwidth);
    x = [x,elongation];
    
    %feature 8: average distance to centroid
    centroid = r.Centroid;
    imge = imerode(bw_img,strel('disk',1));
    %find non-zero indices in bw image
    [r,c] = find(bw_img-imge);
    avg_dist_to_centroid = mean(sqrt((c-centroid(1)).^2+(r-centroid(2)).^2));
    x = [x,avg_dist_to_centroid];
    
    %feature 9: animal mean color
     if size(img,3)==3
        redChannel = img(:, :, 1);
        greenChannel = img(:, :, 2);
        blueChannel = img(:, :, 3);

        meanR = mean(redChannel(bw_img));
        meanG = mean(greenChannel(bw_img));
        meanB = mean(blueChannel(bw_img));
    else 
        rgbImage = cat(3, img, img, img);
        redChannel = rgbImage(:, :, 1);
        greenChannel = rgbImage(:, :, 2);
        blueChannel = rgbImage(:, :, 3);

        meanR = mean(redChannel(bw_img));
        meanG = mean(greenChannel(bw_img));
        meanB = mean(blueChannel(bw_img));
    end
    
     x = [x,[meanR meanG meanB]];
   
    %regProps = regionprops(binaryIm);

    %feature 10: animal ROI histogram
     %interestPoints = detectSURFFeatures(rgb2gray(img));  
     %x = [x interestPoints];
    
    %......
    


end






    % Turn contour and box into a filled binary image
    %{
    blackRectangle = zeros(bb_hmax-bb_hmin, bb_wmax-bb_wmin);
    ff=figure; set(ff, 'Visible', 'off'); clf; imagesc(blackRectangle); axis image; axis ij; hold on;
    %imshow(blackRectangle)
    for cc = 1:size(contour,2)
       if cc < size(contour,2)
          plot([contour(1,cc), contour(1,cc+1)], [contour(2,cc), contour(2,cc+1)], 'w','linewidth',1);
       else
          plot([contour(1,cc), contour(1,1)], [contour(2,cc), contour(2,1)], 'w','linewidth',1);
       end
    end

    F = getframe(gca);
    im = F.cdata;
    
    BW = im2bw(im, 0.5);
    binaryIm = imfill(BW,'holes'); %ERROR HERE WITH IMAGE image_0010.jpg
    figure, imshow(binaryIm)
    %figure, imshow(binaryIm)
    %}