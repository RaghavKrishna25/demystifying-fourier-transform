% 4. Sawtooth Wave, Its Spectrum, Approximation & Noise Spectrum

fs = 1000;                 % Sampling frequency
t = 0:1/fs:1-1/fs;         % Time vector
f = 50;                    % Base frequency

% --- Original Sawtooth Wave ---
x_sawtooth = sawtooth(2*pi*f*t);

% --- Fourier Series Approximation of Sawtooth ---
N = 15;  % Number of harmonics for approximation
x_approx = zeros(size(t));

for k = 1:N
    x_approx = x_approx + (2*(-1)^(k+1) / (k*pi)) * sin(2*pi*f*k*t);
end

% --- Noise Signal (White Gaussian Noise) ---
x_noise = randn(size(t));

% --- FFT Computations ---
X_sawtooth = fft(x_sawtooth);
X_noise = fft(x_noise);
n = length(X_sawtooth);
f_axis = (0:n-1)*(fs/n);

% --- Plotting ---
figure;

% 1. Sawtooth (Time Domain)
subplot(5,1,1);
plot(t, x_sawtooth, 'b', 'LineWidth', 1.5);
title('Sawtooth Wave (Built-in, Time Domain)');
xlabel('Time (s)');
ylabel('Amplitude');
xlim([0 0.05]);
grid on;

% 2. Approximated Sawtooth (Fourier Sum)
subplot(5,1,2);
plot(t, x_approx, 'r', 'LineWidth', 1.5);
title(['Approximated Sawtooth using ', num2str(N), ' Harmonics']);
xlabel('Time (s)');
ylabel('Amplitude');
xlim([0 0.05]);
grid on;

% 3. Spectrum of Sawtooth
subplot(5,1,3);
stem(f_axis(1:n/2), abs(X_sawtooth(1:n/2))/n, 'filled');
title('Magnitude Spectrum of Sawtooth Wave');
xlabel('Frequency (Hz)');
ylabel('Magnitude');
grid on;

% 4. Noise (Time Domain)
subplot(5,1,4);
plot(t, x_noise, 'k', 'LineWidth', 1.2);
title('White Gaussian Noise (Time Domain)');
xlabel('Time (s)');
ylabel('Amplitude');
xlim([0 0.05]);
grid on;

% 5. Spectrum of Noise
subplot(5,1,5);
stem(f_axis(1:n/2), abs(X_noise(1:n/2))/n, 'filled');
title('Magnitude Spectrum of Noise');
xlabel('Frequency (Hz)');
ylabel('Magnitude');
grid on;