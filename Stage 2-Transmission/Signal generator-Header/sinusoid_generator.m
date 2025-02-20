% Generate 1024 sample complex sinusoid and save in a text file
fs = 1024; % Sampling frequency
f = 5; % Frequency of the sinusoid
t = 0:1/fs:1-1/fs; % Time vector
complex_sinusoid = 32 * exp(1i * 2 * pi * f * t); % Generate complex sinusoid

% Extract real and imaginary parts
x_real = real(complex_sinusoid);
x_imag = imag(complex_sinusoid);

% Convert real and imaginary parts to 8-bit integers
x_real_int = uint16(x_real); % Convert real part to 8-bit integer
x_imag_int = uint16(x_imag); % Convert imaginary part to 8-bit integer

% Concatenate real and imaginary parts into 16-bit format
data = bitor(bitshift(x_real_int, 8), x_imag_int);

% Save the data to a txt file
fid = fopen('sinusoid_samples.txt', 'wt');
fprintf(fid, '%04X\n', data);
fclose(fid);
% Plot the real part
subplot(2,1,1);
plot(t, x_real);
title('Real Part of Complex Sinusoid');
xlabel('Time');
ylabel('Amplitude');

% Plot the imaginary part
subplot(2,1,2);
plot(t, x_imag);
title('Imaginary Part of Complex Sinusoid');
xlabel('Time');
ylabel('Amplitude');

sgtitle('Real and Imaginary Parts of Complex Sinusoid');
disp('Data saved to complex_sinusoid.txt');