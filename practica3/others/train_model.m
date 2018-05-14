%function [categoryClassifier] = train_model
categories = {'ant', 'beaver', 'crab', 'crayfish', 'crocodile', 'dolphin', 'dragonfly', 'elephant', 'emu', 'flamingo', 'kangaroo', 'panda'};
imds = imageDatastore(fullfile('../animals', categories), 'LabelSource', 'foldernames');
tbl = countEachLabel(imds)
minSetCount = min(tbl{:,2}); % determine the smallest amount of images in a category

% Use splitEachLabel method to trim the set.
imds = splitEachLabel(imds, minSetCount, 'randomize');

% Notice that each set now has exactly the same number of images.
countEachLabel(imds)

[trainingSet, validationSet] = splitEachLabel(imds, 0.8, 'randomize');

bag = bagOfFeatures(trainingSet);

img = readimage(imds, 1);
featureVector = encode(bag, img);

% Plot the histogram of visual word occurrences
figure
bar(featureVector)
title('Visual word occurrences')
xlabel('Visual word index')
ylabel('Frequency of occurrence')

categoryClassifier = trainImageCategoryClassifier(trainingSet, bag);

display('ei');

confMatrix = evaluate(categoryClassifier, validationSet);
mean(diag(confMatrix));
%end
