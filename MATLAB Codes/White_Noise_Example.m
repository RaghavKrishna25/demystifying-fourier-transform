% Noise Signal: Spectrum + Approximation via Frequency Filtering

fs = 1000;                 % Sampling frequency
t = 0:1/fs:1-1/fs;         % Time vector

% --- Generate White Gaussian Noise ---
x_noise = randn(size(t));

% --- FFT of Noise ---
X_noise = fft(x_noise);
n = length(X_noise);
f_axis = (0:n-1)*(fs/n);

% --- Low-Pass Filtering in Frequency Domain (Keep only first 50 Hz) ---
cutoff = 50;                              % Cutoff frequency (Hz)
index_cutoff = floor(cutoff * n / fs);    % Index up to which to retain

X_filtered = zeros(size(X_noise));
X_filtered(1:index_cutoff) = X_noise(1:index_cutoff);
X_filtered(end - index_cutoff + 1:end) = X_noise(end - index_cutoff + 1:end);  % Symmetry

% --- Inverse FFT to Reconstruct Filtered Signal ---
x_filtered = real(ifft(X_filtered));

% --- Plotting ---
figure;

% 1. Original Noise (Time Domain)
subplot(4,1,1);
plot(t, x_noise, 'k', 'LineWidth', 1.2);
title('Original White Noise (Time Domain)');
xlabel('Time (s)');
ylabel('Amplitude');
xlim([0 0.05]);
grid on;

% 2. FFT Spectrum of Noise
subplot(4,1,2);
stem(f_axis(1:n/2), abs(X_noise(1:n/2))/n, 'filled');
title('Magnitude Spectrum of Noise');
xlabel('Frequency (Hz)');
ylabel('Magnitude');
grid on;

% 3. Filtered/Reconstructed Noise (Time Domain)
subplot(4,1,3);
plot(t, x_filtered, 'b', 'LineWidth', 1.5);
title(['Reconstructed Signal Using < ', num2str(cutoff), ' Hz Components']);
xlabel('Time (s)');
ylabel('Amplitude');
xlim([0 0.05]);
grid on;

% 4. Magnitude Spectrum of Filtered Signal
subplot(4,1,4);
stem(f_axis(1:n/2), abs(X_filtered(1:n/2))/n, 'filled');
title('Filtered Spectrum (Low-Pass)');
xlabel('Frequency (Hz)');
ylabel('Magnitude');
grid on;