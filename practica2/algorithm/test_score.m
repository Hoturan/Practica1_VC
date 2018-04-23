%when debug is true, the test outputs the result for every image
debug = false;

models = '../models/';
models_grans = '../models_grans/';

model_used = models_grans;

global acmilan1 acmilan2 acmilan3
acmilan1 = imread(strcat(model_used, 'acmilan/35.jpg'));
acmilan2 = imread(strcat(model_used,'acmilan/07.jpg'));
acmilan3 = imread(strcat(model_used, 'acmilan/11.jpg'));

global barcelona1 barcelona2 barcelona3
barcelona1 = imread(strcat(model_used, 'barcelona/04.jpg'));
barcelona2 = imread(strcat(model_used, 'barcelona/20.jpg'));
barcelona3 = imread(strcat(model_used, 'barcelona/29.jpg'));

global chelsea1 chelsea2 chelsea3
chelsea1 = imread(strcat(model_used,'chelsea/16.jpg'));
chelsea2 = imread(strcat(model_used, 'chelsea/10.jpg'));
chelsea3 = imread(strcat(model_used, 'chelsea/18.jpg'));

global juventus1 juventus2 juventus3
juventus1 = imread(strcat(model_used, 'juventus/27.jpg'));
juventus2 = imread(strcat(model_used, 'juventus/09.jpg'));
juventus3 = imread(strcat(model_used, 'juventus/36.jpg'));


global liverpool1 liverpool2 liverpool3
liverpool1 = imread(strcat(model_used, 'liverpool/25.jpg'));
liverpool2 = imread(strcat(model_used, 'liverpool/11.jpg'));
liverpool3 = imread(strcat(model_used, 'liverpool/24.jpg'));


global madrid1 madrid2 madrid3
madrid1 = imread(strcat(model_used, 'madrid/31.jpg'));
madrid2 = imread(strcat(model_used, 'madrid/17.jpg'));
madrid3 = imread(strcat(model_used, 'madrid/35.jpg'));


global psv1 psv2 psv3
psv1 = imread(strcat(model_used, 'psv/31.jpg'));
psv2 = imread(strcat(model_used, 'psv/17.jpg'));
psv3 = imread(strcat(model_used, 'psv/39.jpg'));


teams = dir('../soccer');
teams(1:2) = [];

if strcmp(teams(1).name, '.DS_Store')
    teams(1) = [];
end

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



