% This script demonstrates the generation of a square wave using MATLAB's built-in function
% and approximates the same by summing odd harmonics of sine waves.
% It also computes and plots the FFT magnitude spectrum of the square wave.

fs = 1000;                    % Sampling frequency in Hz
t = 0:1/fs:1-1/fs;            % Time vector for 1 second duration
fundamental = 50;             % Fundamental frequency of square wave (Hz)

% Generate built-in square wave using MATLAB's square function
x_square = square(2*pi*fundamental*t);

% Plot the built-in square wave in time domain
figure;
subplot(3,1,1);
plot(t, x_square, 'LineWidth', 1.5);
title('Square Wave (Built-in)');
xlabel('Time (s)');
ylabel('Amplitude');
xlim([0 0.05]);               % Zoom into first 50 ms for detail
grid on;

% Compute FFT of the square wave
X_square = fft(x_square);
n = length(X_square);          % Number of points in FFT
f_axis = (0:n-1)*(fs/n);       % Frequency axis for plotting

% Plot the magnitude spectrum of the square wave
subplot(3,1,2);
stem(f_axis(1:n/2), abs(X_square(1:n/2))/n, 'filled'); % Plot positive frequencies only
title('Magnitude Spectrum of Square Wave');
xlabel('Frequency (Hz)');
ylabel('Magnitude');
grid on;

% Approximate the square wave by summing odd harmonics of sine waves
numHarmonics = 7;              % Number of odd harmonics to include
x_sum = zeros(size(t));        % Initialize sum of harmonics

subplot(3,1,3);
hold on;
colors = lines(numHarmonics);  % Generate distinct colors for each plot

for k = 1:numHarmonics
    harmonic = 2*k - 1;        % Odd harmonics: 1, 3, 5, ...
    % Add current harmonic scaled by 1/harmonic to the sum
    x_sum = x_sum + (1/harmonic)*sin(2*pi*harmonic*fundamental*t);
    
    % Plot the current approximation of the square wave
    plot(t, (4/pi)*x_sum, 'Color', colors(k,:), 'DisplayName', ...
        ['Sum of ' num2str(harmonic) ' harmonics']);
    
    pause(0.5);  % Pause to visually observe build-up; remove if generating static plots
end

title('Square Wave Approximation by Adding Harmonics');
xlabel('Time (s)');
ylabel('Amplitude');
xlim([0 0.05]);               % Zoom into first 50 ms
legend('show');               % Display legend showing number of harmonics
grid on;
hold off;
