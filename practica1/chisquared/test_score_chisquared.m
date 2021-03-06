%when debug is true, the test outputs the result for every image
debug = true;
threshold = 0.0494;

global mod1 mod2 mod3 mod4 mod5 mod6


teams = dir('../soccer');
mod1 = imread('../models/01.jpg');
mod2 = imread('../models/04.jpg');
mod3 = imread('../models/20.jpg');
mod4 = imread('../models/23.jpg');
mod5 = imread('../models/29.jpg');
mod6 = imread('../models/39.jpg');

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
false_negatives_rate = (n-fcb_count)/n * 100;


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
    false_postives = false_positives + fcb_count;
end
false_positives_rate = false_positives/(total_size * 100);

fprintf('------------------------------------------.\n');
fprintf(' model detects  %.2f %% as false positives.\n', false_positives_rate);
fprintf(' model detects  %.2f %% as false negatives.\n', false_negatives_rate);


