numbers = [100, 100, 100, 100];

% Open the original file in append mode and copy content to a temporary file
copyfile('scrambled.txt', 'temp_file.txt');

% Open the original file in write mode
fileID = fopen('header.txt', 'w');

% Write the 4 numbers at the beginning again
fprintf(fileID, '%04X\n', numbers);

% Append the content of the temporary file to the original file
tempFileID = fopen('temp_file.txt', 'r');
while ~feof(tempFileID)
    line = fgetl(tempFileID);
    fprintf(fileID, '%s\n', line);
end

% Close the files
fclose(fileID);
fclose(tempFileID);

% Delete the temporary file
delete('temp_file.txt');
