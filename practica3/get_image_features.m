function x = get_image_features(img,box_coord,contour)
 %figure, imshow(image)
%for a certain image, we must extract features
%this functions returns an array of features
    bb_hmin = box_coord(1);
    bb_hmax = box_coord(2);
    bb_wmin = box_coord(3);
    bb_wmax = box_coord(4);
    c_x = contour(1,:);
    c_y = contour(2,:);
    
    %generate bw image
    bb_img = img(bb_hmin:bb_hmax,bb_wmin:bb_wmax);
    bw_img = roipoly(bb_img,c_x,c_y);
    
    %BOUNDING BOX AREA
    bb_area = (bb_hmax-bb_hmin)*(bb_wmax-bb_wmin);
    %ANIMAL AREA (bwarea returns area of white pixels)
    animal_area = bwarea(bw_img);

    

    
    %feature 1: ratio between bb area and animal area
    ratio_animal_area_to_bb = animal_area / bb_area;
       
    %feature 2: compact area 
    ee = strel('disk',10);
    compact_area = bwarea(imopen(bw_img,ee));
    
    %feature 3: regionprops 
    %regProps = regionprops(binaryIm);


    
    
    %......
    
    
    %return array of features (now it has only one feature
    x = [ratio_animal_area_to_bb,compact_area];


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