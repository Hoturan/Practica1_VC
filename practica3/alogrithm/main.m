%when debug is true, the test outputs the result for every image
debug = false;


animals = dir('../animals');
animals(1:2) = [];

if strcmp(animals(1).name, '.DS_Store')
    animals(1) = [];
end

keySet = {'ant', 'beaver', 'crab', 'crayfish', 'crocodile', 'dolphin', 'dragonfly', 'elephant', 'emu', 'flamingo', 'kangaroo', 'panda'};
valueSet = {[] [] [] [] [] [] [] [] [] [] [] []};

annMap = containers.Map(keySet,valueSet, 'UniformValues',false);

for animals = animals'
    files = dir(['../animals/',animals.name]);
    files(1:2) = [];
    images = files;
   
    for k = 1:length(files)
        baseFileName = files(k).name;
        [filepath,name,ext] = fileparts(['../animals/',animals.name,'/',baseFileName]);
        if ext == ".mat"
            annMap(animals.name) = vertcat(annMap(animals.name), convertCharsToStrings(['../animals/',animals.name,'/',baseFileName]));
        else
            break
        end
    end
    
end