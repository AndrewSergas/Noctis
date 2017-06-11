% Elapsed loading time
tic;

% Loading SVMs and threholds
load(strcat(fileparts(pwd), '\workspace.mat'));

% Elapsed laoding time
totalTime = toc;
fprintf('Elapsed SVM structure loading time: %.4f seconds.\n', totalTime);

% Elasped recognition time
tic;

% Signature's features
path = signaturePath(true, 2, 1, 1);
[x, y, timestamp, pressure] = readSignature(path);
sigFeatures = signatureFeatures(x, y, timestamp, pressure);

% Signature's score
SVM = SVMStruct1(1).svm;
[~, score] = predict(SVM, sigFeatures);

% Signature's recognition
threshold = thresholds1(1);
fprintf('Expected result: genuine\n');
if (score >= threshold)
    fprintf('The signature has been recognized as genuine.\n');
else
    fprintf('The signature has been recognized as forgery.\n');
end

% Elasped recognition time
totalTime = toc;
fprintf('Elapsed signature recognition time: %.4f seconds.\n\n', totalTime);

% Clearing workspace
clear variables;