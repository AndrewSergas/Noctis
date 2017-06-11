if (strcmp(computer('arch'), 'win64')) 
    slash = '\';
else
    slash = '/';
end

% Getting .mat file's size
matObject = matfile(strcat(fileparts(pwd), slash, 'workspace.mat'));
infoMat = whos(matObject);
sizeMat = infoMat.bytes;
sizeMat = sizeMat / 1000000;

% Getting variables' size
load(strcat(fileparts(pwd), slash, 'workspace.mat'));
infoSVMStruct1 = whos('SVMStruct1');
infoSVMStruct2 = whos('SVMStruct2');
infoThresholds1 = whos('thresholds1');
infoThresholds2 = whos('thresholds2');

sizeSVMStruct1 = infoSVMStruct1.bytes;
sizeSVMStruct2 = infoSVMStruct2.bytes;
sizeThresholds1 = infoThresholds1.bytes;
sizeThresholds2 = infoThresholds2.bytes;

sizeSVMStruct1 = sizeSVMStruct1 / 1000000;
sizeSVMStruct2 = sizeSVMStruct2 / 1000000;
sizeThresholds1 = sizeThresholds1 / 1000000;
sizeThresholds2 = sizeThresholds2 / 1000000;

sizeVariables = sizeSVMStruct1 + sizeSVMStruct2 + sizeThresholds1 + sizeThresholds2;

% Calculating .mat file's size for 10,000 users
sizeMatRealCase = sizeMat * 10000 / 94;

% Calculating variables' size for 10,000 users
sizeVariablesRealCase = sizeVariables * 10000 / 94;

% Printing results
fprintf('Size of .mat file for 94 users: %.2f MB\n', sizeMat);
fprintf('Size of variables in workspace for 94 users: %.2f MB\n', sizeVariables);
fprintf('Size of .mat file in a realistic case for 10,000 users: %.2f MB\n', sizeMatRealCase);
fprintf('Size of variables in workspace in a realistic case for 10,000 users: %.2f MB\n\n', sizeVariablesRealCase);

% Clearing workspace
clear variables;