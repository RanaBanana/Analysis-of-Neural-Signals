function [decrypted_mess] = crack_hill2(encrypted_mess,known_word)
%CRACK_HILL2 cracks a Hill 2-cipher.
%   Suppose you intercept a letter to the dean of the Faculty of Science encoded with a Hill 2-cipher that
%   starts with HMRZHMNNRNNHGCHJMQZPVNWFLM. Write a function that accepts this (or any) string,
%   encoded with a Hill 2-cipher and cracks the code. The function should just return the plaintext
%   message.

% encrypted_mess = The encrypted message that needs to be decrypted
% known_word = The word you know for sure that needs to be in the encrypted
%               message. For example in a letter, the letter will start with 
%               the word 'dear'.

DEAR = [3 0 ; 4 17];
HMRZ = [7 17; 12 25];

dHMRZ = det(HMRZ)

a = HMRZ(1,1);
b = HMRZ(1,2);
c = HMRZ(2,1);
d = HMRZ(2,2);

HMRZ_inv(1,1) = d;
HMRZ_inv(1,2) = -b;
HMRZ_inv(2,1) = -c;
HMRZ_inv(2,2) = a;

[~,ModMultInv] = multinverse(dHMRZ,26)
HMRZ_inv = mod(ModMultInv*mod(HMRZ_inv,26),26)



end

