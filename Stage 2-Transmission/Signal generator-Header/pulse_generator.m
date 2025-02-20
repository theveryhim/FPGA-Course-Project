% Generate 1024 samples of a pulse signal with higher frequency
t = 0:1023;
x = zeros(1, 1024);
x(1:256) = 64;
x(513:768) = 64;

% Convert the samples to 16-bit values
samples = uint16(x);

% Combine the real and imaginary parts into a single 16-bit value
samples_combined = bitshift(samples, 8);

% Write the samples to a text file
fid = fopen('pulse_samples.txt', 'w');
fprintf(fid, '%04X\n', samples_combined);
fclose(fid);
% Plot the pulse wave
figure;
plot(t, x);
grid on;
xlabel('Sample Index');
ylabel('Amplitude');
title('pulse Wave');
