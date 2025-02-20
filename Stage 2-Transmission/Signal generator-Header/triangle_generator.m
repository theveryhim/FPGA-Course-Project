% Generate 1024 samples of a non-negative triangle wave
t = 0:1023;
x = abs(mod(t, 128) - 64);

% Convert the samples to 16-bit values
real_part = uint16(x);
imag_part = uint16(zeros(1, 1024));

% Combine the real and imaginary parts into a single 16-bit value
samples_combined = bitor(bitshift(real_part, 8), imag_part);

% Write the samples to a text file
fid = fopen('triangle_samples.txt', 'w');
fprintf(fid, '%04X\n', samples_combined);
fclose(fid);

% Plot the triangle wave
figure;
plot(t, x);
grid on;
xlabel('Sample Index');
ylabel('Amplitude');
title('Triangle Wave');
