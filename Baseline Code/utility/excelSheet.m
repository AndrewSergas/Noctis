%> This utility function returns a cell matrix that will be written on an .xls file; it contains all the users' scores, thresholds, FRRs and FARs

%> @param usersFRR       all users' FRR
%> @param usersFAR       all users' FAR
%> @param scoresGenuine1 scores of the genuine tests for first folder
%> @param scoresGenuine2 scores of the genuine tests for second folder
%> @param scoresForgery1 scores of the forgery tests for first folder
%> @param scoresForgery2 scores of the forgery tests for second folder
%> @param thresholds1    all users' thresholds for first folder
%> @param thresholds2    all users' thresholds for second folder

%> @retval excelSheet    cell matrix containing all the users' scores, thresholds, FRRs and FARs

%> @author Andrea Sergas Donato Meoli
function [ excelSheet ] = excelSheet( usersFRR, usersFAR, scoresGenuine1, scoresGenuine2, scoresForgery1, scoresForgery2, thresholds1, thresholds2 )

sizeScores = size(scoresGenuine1);
usersNumber = sizeScores(1);
signaturesNumber = sizeScores(2) + 1;
sizeRows = usersNumber * signaturesNumber + 1;
excelSheet = cell(sizeRows - 1, 11);
excelSheet(1, 1 : 11) = [{'User Number'}, {'Genuine Scores 1'}, {'Forgery Scores 1'}, {'Thresholds 1'}, {'Genuine Scores 2'}, {'Forgery Scores 2'}, {'Thresholds 2'}, {'User FRRs'}, {'User FARs'}, {'Total FRR'}, {'Total FAR'}];

FRR = mean(usersFRR);
FAR = mean(usersFAR);
excelSheet(2, 10) = num2cell(FRR);
excelSheet(2, 11) = num2cell(FAR);

currentUser = 1;
scoresIndex = 1;

for i = 2 : sizeRows - 1
    if (scoresIndex == signaturesNumber)
        scoresIndex = 1;
        currentUser = currentUser + 1;
    end
    
    if (i - 2 == (currentUser - 1) * (signaturesNumber))
        excelSheet(i, 1) = num2cell(currentUser);
        excelSheet(i, 4) = num2cell(thresholds1(currentUser));
        excelSheet(i, 7) = num2cell(thresholds2(currentUser));
        excelSheet(i, 8) = num2cell(usersFRR(currentUser));
        excelSheet(i, 9) = num2cell(usersFAR(currentUser));
    end
    
    if (i - 1 ~= (currentUser - 1) * (signaturesNumber))
        excelSheet(i, 2) = num2cell(scoresGenuine1(currentUser, scoresIndex));
        excelSheet(i, 3) = num2cell(scoresForgery1(currentUser, scoresIndex));
        excelSheet(i, 5) = num2cell(scoresGenuine2(currentUser, scoresIndex));
        excelSheet(i, 6) = num2cell(scoresForgery2(currentUser, scoresIndex));
        scoresIndex = scoresIndex + 1;
    end
end

end