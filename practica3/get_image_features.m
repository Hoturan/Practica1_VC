function x = get_image_features(img,box_coord,contour)
%for a certain image, we must extract features
%this functions returns an array of features

%% preparation 
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



%% GRANULOMETRIES

%ratio of compact area to animal area
u = bb_area/100000; 
v = [];
l = [];
for i=1:10
    disk_size = round(i*u*2);
    ee = strel('disk',double(disk_size));
    ero_img = imerode(bw_img,ee);
    v = [v,bwarea(ero_img)];
    cc = bwconncomp(ero_img);
    l = [l,cc.NumObjects];
end

[~,i1] = max(abs(v(2:end)-v(1:end-1)));
[~,i2] = max(abs(l(2:end)-l(1:end-1)));
x = [x,i1,i2];
    
%to normalize
ee = strel('disk',10);
compact_img = imopen(bw_img,ee);
compact_ratio = bwarea(compact_img)/animal_area;
x = [x,compact_ratio];

%ratio of compact bb area to original bb area
r_compact = regionprops(compact_img,'BoundingBox');
compact_bb = r_compact.BoundingBox;
compact_bb_area = (compact_bb(2)-compact_bb(1))*(compact_bb(4)-compact_bb(3));
ratio_compact_bb = compact_bb_area/bb_area;
x = [x,ratio_compact_bb];

%% REGIONPROPS AND STANDARD FEATURES

%rectangularity -> ratio between bb area and animal area
rectangularity = animal_area / bb_area;
x = [x,rectangularity];  

r = regionprops(bw_img,'MajorAxisLength','convexHull','Perimeter','Centroid','MinorAxisLength','Orientation');

%orientation
orientation = max([r.Orientation]);
x = [x,orientation];

%major axis length
max_major_axis_length = max([r.MajorAxisLength]);
x = [x,max_major_axis_length/animal_area];

%minor axis length
max_minor_axis_length = max([r.MinorAxisLength]);
x = [x,max_minor_axis_length/animal_area];

%excentricity
excentricity = max_major_axis_length/max_minor_axis_length;
x = [x,excentricity];

%difference animal area vs convex hulls areas
sum_convex_hulls_area = sum(cellfun(@(ch) polyarea(ch(:,1),ch(:,2)),{r.ConvexHull}));
ratio_convex_hull_to_animal_areas = animal_area/sum_convex_hulls_area;
x = [x,ratio_convex_hull_to_animal_areas];   

%compacity
perimeter = sum([r.Perimeter]);
compacity = perimeter^2/animal_area;
x = [x,compacity];

%elongation
elongation = max(bbheight,bbwidth)/min(bbheight,bbwidth);
x = [x,elongation];

%average distance to centroid
centroid = r.Centroid;
imge = imerode(bw_img,strel('disk',1));
contour_img = bw_img-imge;
[r,c] = find(contour_img);
avg_dist_to_centroid = mean(sqrt((c-centroid(1)).^2+(r-centroid(2)).^2));
x = [x,avg_dist_to_centroid];

 %% GENERAL FOURIER DESCRIPTOR
 %select largest object (gfd only accepts one object)
 [L, num] = bwlabel(bw_img, 8);
 obj_areas = sum(bsxfun(@eq,L(:),1:num));
 [~,ind] = max(obj_areas);
 biggest_object = (L==ind);
 % center the object 
 biggest_object = centerobject(biggest_object);
 %gfd
 fd = gfd(biggest_object,4,8);
 x = [x,fd'];

%% COLOR FEATURES 
if size(img,3)==3
     lab_img = rgb2lab(img);
else
     lab_img = rgb2lab(cat(3, img, img, img));
end
L = lab_img(:, :, 1);
A = lab_img(:, :, 2);
B = lab_img(:, :, 3);

%animal mean color
meanL = mean(L(bw_img));
meanA = mean(A(bw_img));
meanB = mean(B(bw_img));
x = [x,[meanL meanA meanB]];


%mitjana desviacio. Parametres estadistics d'un histograma
M = [imhist(L(bw_img)), imhist(A(bw_img)), imhist(B(bw_img))];
stdv = std(M);
%hist = imhist(rgb_img(bw_img));
x = [x,stdv];


%std in 3d histogram
if size(img,3)==3
     rgb_img = img;
else
     rgb_img = cat(3, img, img, img);
end

nelem = numel(img)/3;
nbins = 5;
[freq] = image_hist_RGB_3d(rgb_img, 5);
freq = reshape(freq,1,nbins^3)./nelem;
stdv = std(freq);
x = [x,stdv];

end

