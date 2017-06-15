%> This function returns displacement, velocity, acceleration and pressure as the signature's features

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

for i = 1 : sizeFeatures - 1
    displacement(i) = sqrt((y(i+1) - y(i))^2 + (x(i+1) - x(i))^2);
    velocity(i) = displacement(i) / (timestamp(i+1) - timestamp(i));
    acceleration(i) = velocity(i) / (timestamp(i+1) - timestamp(i));
end

displacement(i) = displacement(i-1);
velocity(i) = velocity(i-1);
acceleration(i) = acceleration(i-1);

sigFeatures = [displacement, velocity, acceleration, pressure];

end