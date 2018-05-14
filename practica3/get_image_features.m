function x = get_image_features(image,box_coord,contour)

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
    
    
    %feature 1: ratio between bb area and animal area
    ratio_animal_area_to_bb = animal_area / bb_area;
    
    
    %feature 2: 
    
    
    %feature 3:
    
    
    %......
    
    
    %return array of features (now it has only one feature
    x = [ratio_animal_area_to_bb];


end
