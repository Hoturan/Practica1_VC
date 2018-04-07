%when debug is true, the test outputs the result for every image
debug = false;
threshold = 0.22;

global mod1 mod2 mod3 mod4 mod5 mod6

teams = dir('../soccer');
mod1 = imread('../models/01.jpg');
mod2 = imread('../models/04.jpg');
mod3 = imread('../models/20.jpg');
mod4 = imread('../models/23.jpg');
mod5 = imread('../models/29.jpg');
mod6 = imread('../models/39.jpg');

% remove . and .. directories
teams(1:2) = [];
for team = teams'
    fprintf('analyzing %s... ',team.name);
    images = dir(['../soccer/',team.name]);
    images(1:2) = [];
    n = length(images);
    fcb_count = 0;
    for image = images'
        im = imread(['../soccer/',team.name,'/',image.name]);
        im = histeq(im);
        score = get_score_chisquared(im);
        %score = min(score);
        if score < threshold 
            fcb_count = fcb_count + 1;
        end
        if debug
            fprintf(' %s, score: %d\n',image.name,score);
        end
    end
    fprintf(' model detects %.2f %% of FCB images.\n',fcb_count/n*100);
end