%> This function returns the SVM classifier and the threshold array for a user

%> @param userFeatures user's signatures' features table

%> @retval SVM         SVM classifier
%> @retval threshold   user's threshold

%> @author Andrea Sergas Donato Meoli
function [ SVM, threshold ] = userSVM( userFeatures )

sizeUserFeatures = size(userFeatures);
sizeUserFeatures = sizeUserFeatures(1);
forgFeatures = forgeryFeatures(userFeatures);
class = ones(sizeUserFeatures, 1);

SVM = fitcsvm(userFeatures, class, 'KernelScale', 'auto', 'Standardize', true);
[~, scoresForgery] = predict(SVM, forgFeatures);
threshold = max(scoresForgery) + 1e-7;
SVM = compact(SVM);

end