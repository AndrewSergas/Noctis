if (strcmp(computer('arch'), 'win64')) 
    slash = '\';
else
    slash = '/';
end

% Elapsed time
tic;

% 2 fold cross validation
[scoresGenuine1, scoresForgery1, thresholds, SVMStruct1] = scores(1, 115, 10);
thresholds1 = transpose(thresholds);
[scoresGenuine2, scoresForgery2, thresholds, SVMStruct2] = scores(2, 115, 10);
thresholds2 = transpose(thresholds);

% Calculating FRR and FAR
[usersFRR, usersFAR] = usersFRRFAR(scoresGenuine1, scoresGenuine2, scoresForgery1, scoresForgery2, thresholds1, thresholds2);

% Writing an .xls file with FRRs and FARs
excel = excelSheet(usersFRR, usersFAR, scoresGenuine1, scoresGenuine2, scoresForgery1, scoresForgery2, thresholds1, thresholds2);
excelPath = strcat(fileparts(pwd), slash, 'Noctis Results');
xlswrite(excelPath, excel);

% Elapsed time
totalTime = toc;
hours = fix(totalTime / 3600);
minutes = fix((totalTime / 3600 - hours) * 60);
seconds = fix(((totalTime / 3600 - hours) * 60 - minutes) * 60);
fprintf('Elapsed training & testing time: %d:%d:%d.\n', hours, minutes, seconds);

% Elapsed time for a realistic case with 10,000 users
totalTime = totalTime * 10000 / 94;
hours = fix(totalTime / 3600);
minutes = fix((totalTime / 3600 - hours) * 60);
seconds = fix(((totalTime / 3600 - hours) * 60 - minutes) * 60);
fprintf('Elapsed training & testing time in a realistic case for 10,000 users: %d:%d:%d.\n', hours, minutes, seconds);

% FRR and FAR
fprintf('Total FRR: %.2f%%.\n', mean(usersFRR) * 100);
fprintf('Total FAR: %.2f%%.\n\n', mean(usersFAR) * 100);

% Saving SVMs and thresholds
save(strcat(fileparts(pwd), slash, 'Data.mat'), 'SVMStruct1', 'SVMStruct2', 'thresholds1', 'thresholds2');

% Clearing workspace
clear variables;