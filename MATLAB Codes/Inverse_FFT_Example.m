% Inverse FFT example

fs = 1000;
t = 0:1/fs:1-1/fs;
f = 50;

% Generate sine wave
x = sin(2*pi*f*t);

% FFT and IFFT
X = fft(x);
x_reconstructed = ifft(X);

figure;
subplot(2,1,1);
plot(t, x, 'LineWidth', 1.5);
title('Original Sine Wave');
xlabel('Time (s)');
ylabel('Amplitude');
xlim([0 0.05]);
grid on;

subplot(2,1,2);
plot(t, real(x_reconstructed), '--r', 'LineWidth', 1.5);
title('Reconstructed Signal using IFFT');
xlabel('Time (s)');
ylabel('Amplitude');
xlim([0 0.05]);
grid on;

% Explanation:
% IFFT perfectly reconstructs the original signal from frequency components.