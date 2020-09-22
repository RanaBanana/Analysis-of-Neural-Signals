function [K_crypt, Kinv_crypt] = hill2(t,k)
% This function encrypts and decrypts plaintext using a given Hill 2-
% cipher with entries from Z26.
% Input t: string of plaintext.
% k = key as a four-letter word as string.

%% Input checks
% Check if key is valid according to the valid_key function
[p] = valid_key(k);
if p == 0  
     error("This key is invalid. Please enter a valid four-letter key. A valid key contains 4 letters and has a multiplicative inverse.") 
end

% Convert a string of letters to their corresponding number, to make it so 
% that each letter has a corresponding number (0-25). 
t_num = letterToNumber(t); 

% Input check for when x is odd. The last element will be repeated once, so that the length of t_num is even.
if mod(length(t_num),2)~=0 
     t_num(length(t_num)+1) = t_num(length(t_num)); 
end

% Create matrix for text (tm), x[1] goes to tm[1,1], x[2]-> tm[1,2] etc.
tm = zeros(2);
count = 1;
for i = 1:2:length(t_num)
    tm(1:2,count) = [t_num(i);t_num(i+1)]; 
    count = count+1;
end
%% Calculate K and Kinv
% Converting the letters of k to their corresponding number.
x = letterToNumber(k);  

% Create matrix K
K = [x(1:2);x(3:4)];

% Calculate the determinant for matrix K.
dK = det(K);

% The modular inverse of a matrix A: mod(inv(A) * det(A) * 
% multiplicative_inverse(det(A)), length(alphabet))
[~,ModMultInv] = multinverse(mod(dK,26),26);
Kinv = round(mod(inv(K) * dK * ModMultInv, 26));

%% Generate output
% Calculate the numbers within Z26 corresponding to key K (for encoding) 
% or inverse key Kinv (for decoding) by taking the modulus of 26 for K*tm and Kinv*tm.
encryption_num = mod(K*tm,26);
decryption_num = mod(Kinv*tm,26);

% Converting the numbers of the output back to a row vector (using (:)') and 
% converting the row vectors back into 'words'
K_crypt = numberToLetter(encryption_num(:)');
Kinv_crypt = numberToLetter(decryption_num(:)');

end



