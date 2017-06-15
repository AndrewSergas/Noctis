if (strcmp(computer('arch'), 'win64')) 
    slash = '\';
else
    slash = '/';
end

addpath(strcat(pwd, slash, 'features-extraction'));
addpath(strcat(pwd, slash, 'scripts'));
addpath(strcat(pwd, slash, 'signature-acquisition'));
addpath(strcat(pwd, slash, 'test'));
addpath(strcat(pwd, slash, 'train'));
addpath(strcat(pwd, slash, 'utility'));

clc
trainAndTest