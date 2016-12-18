% This function is used to collect the data from bike share and weather
% for a specific year and combine the data.

function [combined] = dataExtract(year)

% Bike Share Data
bikeData = csvread(strcat('bike_',num2str(year),'.csv'));
%Weather Data
weatherData = csvread(strcat('weather_',num2str(year),'.csv'));

bikeData = bikeData(:, 1:4);
% Sort based on Year, Month, Day, Hour
bikeData = sortrows(bikeData, [3 1 2 4]);
bikeData = [bikeData ones(size(bikeData, 1), 1)];

%Get count of number of bikes rented per hour
[i,~,j]  = unique(bikeData(:, [1,2,3,4]), 'rows');
bikeData = [i, accumarray(j, bikeData(:, 5), [], @sum)];

months = bikeData(:, 1);
days = bikeData(:, 2);
years = bikeData(:, 3) + 2000;
hours = bikeData(:, 4);
months(months == 1 | months == 2 | months == 3) = 1;
months(months == 3 | months == 4 | months == 5) = 2;
months(months == 7 | months == 8 | months == 9) = 3;
months(months == 10 | months == 11 | months == 12) = 4;
seasons = months;

% Re-Construct bike data in order
bikeData = [seasons years bikeData(:, 1:2) bikeData(:, 4:5)];

% Get day of the week as a feature
dayOfWeeks = zeros(size(bikeData, 1), 1);

for t = 1:size(bikeData, 1)
    dateStr = strcat(num2str(bikeData(t, 2)), '-', num2str(bikeData(t, 3)),'-', num2str(bikeData(t, 4)));
    dayOfWeeks(t) = weekday(dateStr);
end

bikeData = [bikeData(:, 1:5) dayOfWeeks bikeData(:, 6)];

% Combine bike data and weather data based on year, month, day and hour
[~, row1, row2] = intersect(bikeData(:, [2 3 4 5]), weatherData(:, [1 2 3 4]), 'rows');
combined = [bikeData(row1, :), weatherData(row2, 5:9)];
end