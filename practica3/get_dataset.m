function [X, Y] = get_dataset()

%feature vector
x = [];
%labels cell array
y = {};

species = dir('./animals');
species(1:2) = [];
%for every species 
for i=1:size(species)
    images = dir(fullfile('./animals',species(i).name,'*.jpg'));
    annotations = dir(fullfile('./animals',species(i).name,'*.mat'));
    %n is the number of samples of that species
    n = size(images);
    for j=1:n
        image_file = ['./animals/',species(i).name,'/',images(j).name];
        image = imread(image_file);
        annotation_file = ['./animals/',species(i).name,'/',annotations(j).name];
        load(annotation_file, 'box_coord', 'obj_contour');
        %add the image features to the dataset
        x = [x;get_image_features(image,box_coord,obj_contour)];
        %add the image label to the dataset
        label = species(i).name;
        y{end+1} = label;
    end
    display(species(i).name)
end
%return values
X = x;
Y = y';

end