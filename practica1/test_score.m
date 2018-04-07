%when debug is true, the test outputs the result for every image
debug = false;

teams = dir('soccer');
% remove . and .. directories
teams(1:2) = [];
for team = teams'
    fprintf('analyzing %s... ',team.name);
    images = dir(['soccer/',team.name]);
    images(1:2) = [];
    n = length(images);
    fcb_count = 0;
    for image = images'
        im = imread(['soccer/',team.name,'/',image.name]);
        score = image_is_fcb2(im);
        %if score < 0.14
        if score < 0.6
            fcb_count = fcb_count + 1;
        end
        %fprintf(' %s, score: %d\n',image.name,score);
    end
    fprintf(' model detects %.2f %% of FCB images.\n',fcb_count/n*100);
end


%im2 = imread('soccer/barcelona/02.jpg');
