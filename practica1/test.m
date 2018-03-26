%when debug is true, the test outputs the result for every image
debug = false;

teams = dir('soccer')
% remove . and .. directories
teams(1:2) = []
for team = teams'
    fprintf('analyzing %s...\n',team.name);
    images = dir(['soccer/',team.name]);
    images(1:2) = [];
    n = length(images);
    fcb_count = 0;
    for image = images'
        im = imread(['soccer/',team.name,'/',image.name]);
        is_fcb = image_is_fcb(im);
        fcb_count = fcb_count + is_fcb; 
        if debug
            if is_fcb
                fprintf('%s is blaugrana\n',image.name);
            else 
                fprintf('%s is NOT blaugrana\n',image.name);
            end
        end
    end
    fprintf('model detects %.2f %% of FCB images.\n\n',fcb_count/n*100);
end


%im2 = imread('soccer/barcelona/02.jpg');
