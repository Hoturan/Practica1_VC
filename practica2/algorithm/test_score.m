%when debug is true, the test outputs the result for every image
debug = false;

global acmilan1 acmilan2 acmilan3
acmilan1 = imread('../models/acmilan/35.jpg');
acmilan2 = imread('../models/acmilan/07.jpg');
acmilan3 = imread('../models/acmilan/11.jpg');

global barcelona1 barcelona2 barcelona3
barcelona1 = imread('../models/barcelona/04.jpg');
barcelona2 = imread('../models/barcelona/20.jpg');
barcelona3 = imread('../models/barcelona/29.jpg');

global chelsea1 chelsea2 chelsea3
chelsea1 = imread('../models/chelsea/16.jpg');
chelsea2 = imread('../models/chelsea/10.jpg');
chelsea3 = imread('../models/chelsea/18.jpg');

global juventus1 juventus2 juventus3
juventus1 = imread('../models/juventus/27.jpg');
juventus2 = imread('../models/juventus/09.jpg');
juventus3 = imread('../models/juventus/36.jpg');


global liverpool1 liverpool2 liverpool3
liverpool1 = imread('../models/liverpool/25.jpg');
liverpool2 = imread('../models/liverpool/11.jpg');
liverpool3 = imread('../models/liverpool/24.jpg');


global madrid1 madrid2 madrid3
madrid1 = imread('../models/madrid/31.jpg');
madrid2 = imread('../models/madrid/17.jpg');
madrid3 = imread('../models/madrid/35.jpg');


global psv1 psv2 psv3
psv1 = imread('../models/psv/31.jpg');
psv2 = imread('../models/psv/17.jpg');
psv3 = imread('../models/psv/39.jpg');


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



