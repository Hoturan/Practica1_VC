%when debug is true, the test outputs the result for every image
debug = false;

global acmilan barcelona chelsea juventus liverpool madrid psv 


acmilan = imread('../models/acmilan/35.jpg');
barcelona = imread('../models/barcelona/04.jpg');
chelsea = imread('../models/chelsea/16.jpg');
juventus = imread('../models/juventus/27.jpg');
liverpool = imread('../models/liverpool/25.jpg');
madrid = imread('../models/madrid/31.jpg');
psv = imread('../models/psv/31.jpg');

teams = dir('../soccer');
teams(1:2) = [];
for team = teams'
    fprintf('analyzing %s... ',team.name);
    images = dir(['../soccer/',team.name]);
    images(1:2) = [];
    n = length(images);
    count = 0;
    for image = images'
        im = imread(['../soccer/',team.name,'/',image.name]);
        team_result = get_team(im);
        if strcmp(team_result,team.name) 
            count = count + 1;
        end
        if debug
            fprintf(' %s, result: %s\n',image.name,team_result);
        end
    end
    fprintf(' model detects %.2f %% of %s images.\n',count/n*100,team.name);
end



