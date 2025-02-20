clc,clear
% Open the input text file for reading
fileID = fopen('triangle_samples.txt', 'r');
X = zeros(1,18);
Y = zeros(1,18);
% Read the data from the file
data = textscan(fileID, '%s', 'Delimiter', '\n');
fclose(fileID);

% Extract the hex values from the data
Values = data{1};

% Initialize output data
outputData = cell(1024, 1);
% Process each value and generate the output
for i = 1:1024
    % Generate a random 2-bit number R using RandomGen function
    [R,X,Y] = RandomGen(i,X,Y);  % Replace with the actual RandomGen function call
    
    I = int8(hex2dec(Values{i}(1:2)));
    Q = int8(hex2dec(Values{i}(3:4)));
    switch R
        case 0
            Is = I;
            Qs = Q;
        case 1
            Is = bitcmp(Q) + 1;  % Two's complement for negative value
            Qs = I;
        case 2
            Is = bitcmp(I) + 1 ;  % Two's complement for negative value
            Qs = bitcmp(Q) + 1;  % Two's complement for negative value
        case 3
            Is = Q;
            Qs = bitcmp(I) + 1;  % Two's complement for negative value
    end
    
    % Concatenate Is and Qs to form the output value
    outputData{i} = [Char(dec2hex(int16(Is))),Char(dec2hex(int16(Qs)))];
end

% Write the output data to a new text file
outputFileID = fopen('triangle_scrambled.txt', 'w');
for i = 1:1024
    fprintf(outputFileID, '%s\n', outputData{i});
end
fclose(outputFileID);
%% 
function ch = Char(in) 
    ch = in;
    if(length(in)==1)
        ch = ['0',in];
    end 
end 
%% 
function [R,X,Y] = RandomGen(i,X,Y)
    if(i==1)
        X(1) = 1;
        Y = ones(1,18);
    else
        X18 = bitxor(X(1),X(8));
        Y18 = bitxor(bitxor(Y(1),Y(6)),bitxor(Y(8),Y(11)));
        for j=1:17
            X(j) = X(j+1);
            Y(j) = Y(j+1);
        end
        X(18) = X18;
        Y(18) = Y18;
    end
    T1 = bitxor(X(1),Y(1));
    T2 = bitxor(bitxor(X(5),X(7)),X(16));
    T3 = bitxor(Y(6),Y(7));
    for k=9:16
        T3 = bitxor(T3,Y(k));
    end
    T4 = bitxor(T3,T2);
    R = T4*2 + T1;
end