function pred = predict_image(clf,img_filename,annotation_filename)
%annotation_filename = 'animals\ant\annotation_0003.mat';
%img_filename = 'animals\ant\image_0003.jpg';

im = imread(img_filename);
load(annotation_filename,'box_coord','obj_contour');

feature_vector = get_image_features(im,box_coord,obj_contour);
[pred,score] = clf.predict(feature_vector);
score

end