function x = get_image_features(image,box_coord,contour)
 %figure, imshow(image)
%for a certain image, we must extract features
%this functions returns an array of features
    bb_hmin = box_coord(1);
    bb_hmax = box_coord(2);
    bb_wmin = box_coord(3);
    bb_wmax = box_coord(4);
    
    c_x = contour(1,:);
    c_y = contour(2,:);
    
    
    bb_area = (bb_hmax-bb_hmin)*(bb_wmax-bb_wmin);
    animal_area = polyarea(c_x,c_y);
    
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
    
    bb_img = image(box_coord(1):box_coord(2),box_coord(3):box_coord(4));
    bw_img = roipoly(bb_img,c_x,c_y);
    
    %feature 1: ratio between bb area and animal area
    ratio_animal_area_to_bb = animal_area / bb_area;
    
    
    %feature 2: regionprops 
    %regProps = regionprops(binaryIm);

    %feature 3: area of legs
%     ee = strel('disk',30);
%     th = imopen(binaryIm,ee);
%     im = binaryIm-th;
%     im = bwareaopen(im,300);
%     areaLegs = regionprops(im);
%     areaLegs = areaLegs.Area;
    
    
    %......
    
    
    %return array of features (now it has only one feature
    x = [ratio_animal_area_to_bb];


end
