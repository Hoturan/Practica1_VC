%when debug is true, the test outputs the result for every image
debug = true;
threshold = 0.0794;

global mod1 mod2 mod3 mod4 mod5 mod6

teams = dir('../soccer');
mod1 = imread('../models/01.jpg');
mod1 = rgb2hsv(mod1);
mod2 = imread('../models/04.jpg');
mod2 = rgb2hsv(mod2);
mod3 = imread('../models/20.jpg');
mod3 = rgb2hsv(mod3);
mod4 = imread('../models/23.jpg');
mod4 = rgb2hsv(mod4);
mod5 = imread('../models/29.jpg');
mod5 = rgb2hsv(mod5);
mod6 = imread('../models/39.jpg');
mod6 = rgb2hsv(mod6);

fprintf('analyzing barcelona... ');
images = dir('../soccer/barcelona');
images(1:2) = [];
n = length(images);
fcb_count = 0;
for image = images'
    im = imread(['../soccer/','barcelona','/',image.name]);
    score = get_score_chisquared(im);
    if score < threshold 
        fcb_count = fcb_count + 1;
    end
    if debug
        fprintf(' %s, score: %d\n',image.name,score);
    end
end
fprintf(' model detects %.2f %% of FCB images.\n',fcb_count/n*100);
false_negatives = 100 - fcb_count/n*100;


% remove . , .. and barcelona directories
teams(1:2) = [];
teams(3) = [];
false_positives = 0;
total_size = 0;
for team = teams'
    fprintf('analyzing %s... ',team.name);
    images = dir(['../soccer/',team.name]);
    images(1:2) = [];
    n = length(images);
    total_size = total_size + n;
    fcb_count = 0;
    for image = images'
        im = imread(['../soccer/',team.name,'/',image.name]);
        score = get_score_chisquared(im);
        if score < threshold 
            fcb_count = fcb_count + 1;
        end
        if debug
            fprintf(' %s, score: %d\n',image.name,score);
        end
    end
    fprintf(' model detects %.2f %% of FCB images.\n',fcb_count/n*100);
     false_positives = false_positives + fcb_count/n*100;
end

fprintf('------------------------------------------.\n');
fprintf(' model detects  %.2f %% as false positives.\n', false_positives/8);
fprintf(' model detects  %.2f %% as false negatives.\n', false_negatives);


