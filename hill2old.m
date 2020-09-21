function [K_crypt, Kinv_crypt] = hill2old(t,k)
% This function encrypts and decrypts plaintext using a given Hill 2-
% cipher with entries from Z26.
% Input t: plaintext; k = key as a four-letter word

%% Input checks
% Check if key is valid according to valid_key function
[p] = valid_key(k);
if p == 0  
     error("This key is invalid. Please enter a valid four-letter key. A valid key contains 4 letters and has a multiplicative inverse.") 
end

% Convert a string of letters to their corresponding number, to make it so 
% that each letter has a corresponding number (0-25). 
t_num = letterToNumber(t); 

% Input check for when x is odd.
if mod(length(t_num),2)~=0 
     t_num(length(t_num)+1) = t_num(length(t_num)); 
end

% Create matrix, x[1] goes to tm[1,1], x[2]-> tm[1,2] etc.
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
 
% Calculate the K inverse by assigning variables a to d to each element
% within the key matrix.
a = K(1,1);
b = K(1,2);
c = K(2,1);
d = K(2,2);

% Assign these values to a new 'Kinv' matrix, which holds the
% values of the matrix used for calculating the Kinv.
Kinv(1,1) = d;
Kinv(1,2) = -b;
Kinv(2,1) = -c;
Kinv(2,2) = a;

% Calculate the K inverse within Z26 (Kinv)
Kinv = mod((multinverse(dK,26)*Kinv),26);

%% Generate output
% Calculate the numbers within Z26 corresponding to the K (for encoding) 
% or Kinv (for decoding) multiplication.
encryption_num = mod(K*tm,26);
decryption_num = mod(Kinv*tm,26);

% Convert the numbers of the output back to a row vector (using (:)') and 
% convert the row vectors back into 'words'
K_crypt = numberToLetter(encryption_num(:)');
Kinv_crypt = numberToLetter(decryption_num(:)');
end



