% Pure Sine Wave and its FFT
% This script generates a pure sine wave and computes its Fast Fourier Transform (FFT)
% to visualize both the time-domain signal and its frequency-domain magnitude spectrum.

fs = 1000;            % Sampling frequency in Hz
t = 0:1/fs:1-1/fs;    % Time vector for 1 second duration (excluding last sample for exact length)
f = 50;               % Frequency of sine wave in Hz

% Generate pure sine wave signal
x = sin(2*pi*f*t);

% Compute FFT of the signal
X = fft(x);
n = length(X);                % Number of FFT points (same as signal length)
f_axis = (0:n-1)*(fs/n);     % Frequency axis for plotting (0 to fs - fs/n)

% Plot the time-domain sine wave
figure;
subplot(2,1,1);
plot(t, x, 'LineWidth', 1.5);
title('Pure Sine Wave (Time Domain)');
xlabel('Time (s)');
ylabel('Amplitude');
xlim([0 0.05]);   % Zoom in to first 50 ms for better visibility of waveform
grid on;

% Plot the magnitude spectrum of the sine wave
subplot(2,1,2);
stem(f_axis(1:n/2), abs(X(1:n/2))/n, 'filled'); % Plot positive frequencies only
title('Magnitude Spectrum of Sine Wave');
xlabel('Frequency (Hz)');
ylabel('Magnitude');
grid on;

% Note:
% The magnitude spectrum shows a single prominent peak at 50 Hz,
% which corresponds to the frequency of the sine wave.
