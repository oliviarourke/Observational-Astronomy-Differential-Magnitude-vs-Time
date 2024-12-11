%% Plotting Data
set(0,'defaultfigurecolor', [1 1 1])
set(0, 'defaultAxesFontSize', 14)
set(0, 'defaultfigureposition', [0 0 700 350])
format compact;
clear all; close all; clc;
format long

%% Import
% data = readmatrix('hat_phot.txt'); 
% data = readmatrix('newdata.txt');  %night 2
data = readmatrix('waspphot2.txt'); 

col1 = data(:, 1);
time = data(:, 2) - 2460215.0;
mag = data(:, 3);
merr = data(:, 4);

time1 = time(col1 == 1);
mag1 = mag(col1 == 1);
merr1 = merr(col1 == 1);

time2 = time(col1 == 2);
mag2 = mag(col1 == 2);
merr2 = merr(col1 == 2);

mdiff = mag1-mag2;
mdifferr = sqrt(merr1.^2 + merr2.^2);


%% Plot 
figure(1);
errorbar(time1, mdiff, mdifferr, 'b.'); 
set(gca, 'YDir', 'reverse'); % Flip the y-axis
xlabel('HJD – 2460215.0');
ylabel('Differential Magnitude');

%hat 
% tstart = 386.66797994077206;
% tend = 386.7954795900732;

%wasp 1
tstart = 397.7944723791443;
tend = 397.88737285276875;

%wasp 2
% tstart= 408.7247994886711;
% tend= 408.81770123681054;

xline(tstart,'k-')
xline(tend,'k-')
legend('Data', 'Transit start time', 'Transit end time')

%% Table 
nRows = min(length(time1))
% Truncate data to the smallest size to avoid mismatches
time_table = time1(1:nRows);
mag1_table = mag1(1:nRows);
mag2_table = mag2(1:nRows);
mdiff_table = mdiff(1:nRows);
mdifferr_table = mdifferr(1:nRows);

% Create the table
resultTable = table(time_table, mag1_table, mag2_table, mdiff_table, mdifferr_table, ...
    'VariableNames', {'Time', 'Mag1', 'Mag2', 'Mdiff', 'MdiffErr'});

% Display the table
disp(resultTable);

