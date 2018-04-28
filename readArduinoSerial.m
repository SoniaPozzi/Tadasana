% Copyright 2014 The MathWorks, Inc.
clear all
close all

%% Create serial object for Arduino
s = serial('/dev/cu.wchusbserial1420', 'BaudRate', 9600); % change the COM Port number as needed
%% Connect the serial port to Arduino
s.InputBufferSize = 1; % read only one byte every time
try
    fopen(s);
catch err
    fclose(instrfind);
    error('Make sure you select the correct COM Port where the Arduino is connected.');
end
%% Create a figure window to monitor the live data
Tmax = 100; % Total time for data collection (s)
figure,
grid on,
xlabel ('Time (s)'), ylabel('Data (8-bit)'),
axis([0 Tmax+1 0 100]),
%% Read and plot the data from Arduino
Ts = 0.02; % Sampling time (s)
i = 0;
data = 0;
t = 0;
tic % Start timer
value = 0;
doi = 1;
final_value = 0;
while toc <= Tmax
    i = i + 1;
    %% Read buffer data
    %k = fscanf(s)
    k = arduino(s)
    %data(i) = k;
    %% Read time stamp
    % If reading faster than sampling rate, force sampling time.
    % If reading slower than sampling rate, nothing can be done. Consider
    % decreasing the set sampling time Ts
    t(i) = toc;
    if i > 1
        T = toc - t(i-1);
        while T < Ts
            T = toc - t(i-1);
        end
    end
    t(i) = toc;
    %% Plot live data
    
    if i > 1
        if (~isempty(k)) && ((k == 13) || (k == 10))
            final_value = value
            value = 0;
            data(i) = final_value;
            line([t(i-1) t(i)],[data(i-1) data(i)])
            drawnow
        else
            value = (value * 10) + (k-48);
        end             
    else
        data(1) = 0;
    end
end
fclose(s);

