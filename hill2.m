function [encryption, decryption] = hill2(t, k)
% This function encrypts and decrypts plaintext using a given Hill 2-
% cipher with entries from ?26.
% Input x: plaintext; k = key as four-letter word

if valid_key(k) == 0
     error("This key is invalid, please enter a four-letter key.")
end

% Input check for when x is odd.
if mod(t,2)~=0
     t(length(t)+1) = t(length(t));
end

% Converting a string of letters to their corresponding number, so each
% letter has a number (0-25). 
t = letterToNumber(t);

% Create matrix, x[1] goes to tm[1,1], x[2]-> tm[1,2] etc.
tm = [];
count = 1;
for i = 1:2:length(t)
    tm(1:2,count) = [t(i);t(i+1)];
    count = count+1;
end

% Inverse key
% Converting the letters of k to their corresponding number.
k = letterToNumber(k);

% Create matrix k
K = [k(1:2);k(3:4)];

% Calculate the determinant for matrix K.
dK = det(K);

a = K(1,1);
b = K(1,2);
c = K(2,1);
d = K(2,2);

Kinv(1,1) = d;
Kinv(1,2) = -b;
Kinv(2,1) = -c;
Kinv(2,2) = a;

Kinv= multinverse(dK,26)*Kinv
Kinv= mod(Kinv,26)

encryption = K*tm
decryption = Kinv*tm

end
