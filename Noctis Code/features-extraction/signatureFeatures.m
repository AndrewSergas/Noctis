%> This function returns the variances ant the means of displacement, velocity, acceleration, angles between two successive points,
%> pressure, time and angles with the origin point variations and the path length and the total time as the signature's features

%> @param x            x coordinates
%> @param y            y coordinates
%> @param timestamp    point acquisition time in milliseconds
%> @param pressure     pressure

%> @retval sigFeatures signature's features array

%> @author Andrea Sergas Donato Meoli
function [ sigFeatures ] = signatureFeatures( x, y, timestamp, pressure )

sizeFeatures = size(x);
sizeFeatures = sizeFeatures(2);

displacement = zeros(1, sizeFeatures);
velocity = zeros(1, sizeFeatures);
acceleration = zeros(1, sizeFeatures);
angles = zeros(1, sizeFeatures);
pressureVariations = zeros(1, sizeFeatures);
timeVariations = zeros(1, sizeFeatures);
originAngles = zeros(1, sizeFeatures);
pathLength = 0;

for i = 1 : sizeFeatures - 1
    displacement(i) = sqrt((y(i+1) - y(i))^2 + (x(i+1) - x(i))^2);
    velocity(i) = displacement(i) / (timestamp(i+1) - timestamp(i));
    acceleration(i) = velocity(i) / (timestamp(i+1) - timestamp(i));
    angles(i) = atan2(y(i+1) - y(i), x(i+1) - x(i));
    pressureVariations(i) = pressure(i+1) - pressure(i);
    timeVariations(i) = timestamp(i+1) - timestamp(i);
    originAngles(i) = atan2(y(i) - 0, x(i) - 0);
    pathLength = pathLength + displacement(i);
end

displacement(i) = displacement(i-1);
velocity(i) = velocity(i-1);
acceleration(i) = acceleration(i-1);
angles(i) = angles(i-1);
pressureVariations(i) = pressureVariations(i-1);
timeVariations(i) = timeVariations(i-1);
originAngles(i) = atan2(y(i) - 0, x(i) - 0);

displacementMean = mean(displacement);
displacementDev = std(displacement);

velocityMean = mean(velocity);
velocityDev = std(velocity);

accelerationMean = mean(acceleration);
accelerationDev = std(acceleration);

anglesMean = mean(angles);
anglesDev = std(angles);

pressureMean = mean(pressureVariations);
pressureDev = std(pressureVariations);

timeMean = mean(timeVariations);
timeDev = std(timeVariations);

originAnglesMean = mean(originAngles);
originAnglesDev = std(originAngles);

totalTime = timestamp(sizeFeatures) - timestamp(1);

sigFeatures = [displacementMean, velocityMean, accelerationMean, anglesMean, pressureMean, timeMean, originAnglesMean,...
    displacementDev, velocityDev, accelerationDev, anglesDev, pressureDev, timeDev, originAnglesDev, pathLength, totalTime];


end