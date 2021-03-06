function [v] = valid_key(x)
% This function checks whether a given four-letter word specifies a
% valid key matrix. The function accepts a four-letter word as input and returns True for a
% valid key matrix (or False otherwise).

if sum(isstrprop(x,'alpha'))~= 4
    error("Please enter four letters within quotation marks (e.g. 'ABCD')")
end
% Convert a string of letters to their corresponding number, so each
% letter has a number (0-25). 
x = letterToNumber(x);

% Create matrix, x[1] goes to K[1,1], x[2]-> K[1,2]; x[3]-> K[2,1]; x[4]-> K[2,2] in
% matrix K.
K = [x(1:2);x(3:4)];

% Calculate the determinant for matrix K.
dK = det(K);

% If the determinant of matrix K (dK) has a multiplicative inverse in mod 
% 26, then [~,c] = multinverse(dK,26) == 1,otherwise ==0. 
% The determinant of matrix K cannot be divided by any number which is a 
% multiple of 2 and/ or 13, because we are using a modulus 26.
c = multinverse(dK,26);

% If c == 1, the key matrix K is a valid key. If c == 0, the key
% matrix K is not a vaid key and therefore cannot be used for en- and
% decryption of a Hill 2-cipher.
if c == 1
    v = true;
else
    v = false;
end
end
