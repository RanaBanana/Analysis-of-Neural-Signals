function [decrypted_mess] = crack(encrypted_mess,known_word)
%CRACK_HILL2 cracks a Hill 2-cipher.
%   Suppose you intercept a letter to the dean of the Faculty of Science encoded with a Hill 2-cipher that
%   starts with HMRZHMNNRNNHGCHJMQZPVNWFLM. Write a function that accepts this (or any) string,
%   encoded with a Hill 2-cipher and cracks the code. The function should just return the plaintext
%   message.

% encrypted_mess = The encrypted message that needs to be decrypted
% known_word = The word you know for sure that needs to be in the encrypted
%               message. For example in a letter, the letter will start with 
%               the word 'dear'.

HELP = [7 11 ; 4 15]
HWAP = [7 0 ; 22 15]

dHWAP = det(HWAP)

a = HWAP(1,1);
b = HWAP(1,2);
c = HWAP(2,1);
d = HWAP(2,2);

HWAP_inv(1,1) = d;
HWAP_inv(1,2) = -b;
HWAP_inv(2,1) = -c;
HWAP_inv(2,2) = a;

[~,ModMultInv] = multinverse(dHWAP,26)
HWAP_inv = mod(ModMultInv*mod(HWAP_inv,26),26)

D = mod(HELP*HWAP_inv,26)

message_NR = mod(D*HWAP,26)
message_NR = message_NR(:)'

message_txt = numberToLetter(message_NR)

end
