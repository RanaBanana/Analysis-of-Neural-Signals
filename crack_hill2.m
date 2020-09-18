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

%% Create encrypted message matrix
% Convert a string of letters to their corresponding number, to make it so 
% that each letter has a corresponding number (0-25). 
en_mess_num = letterToNumber(encrypted_mess); 

% Input check for when encrypted_mess is odd. If it is odd, the last number
% will be copied and concatenated to the series of numbers representing the
% encrypted message.
if mod(length(en_mess_num),2)~=0 
     en_mess_num(length(en_mess_num)+1) = en_mess_num(length(en_mess_num)); 
end

% Create matrix to represent the encrypted message, encrypted_mess[1] goes
% to en_mess_mat[1,1], encrypted_mess[2]-> en_mess_mat[1,2] etc.
% In the for-loop, steps of 2 are taken because each column should contain
% 2 integers, with no overlap from the previous integer. (e.g. [1 3; 2 4]
% instead of [1 2; 2 3])
en_mess_mat = [];
count = 1;
for i = 1:2:length(en_mess_num)
    en_mess_mat(1:2,count) = [en_mess_num(i);en_mess_num(i+1)]; 
    count = count+1;
end

%% create known word matrix
% Convert a string of letters to their corresponding number, to make it so 
% that each letter has a corresponding number (0-25). 
known_word_num = letterToNumber(known_word); 

% Create matrix, known_word[1] goes to known_word_mat[1,1], known_word[2]->
% known_word_mat[1,2] etc.
% In the for-loop, steps of 2 are taken because each column should contain
% 2 integers, with no overlap from the previous integer. (e.g. [1 3; 2 4]
% instead of [1 2; 2 3])
known_word_mat = [];
count = 1;
for i = 1:2:length(known_word_num)
    known_word_mat(1:2,count) = [known_word_num(i);known_word_num(i+1)];
    % Make a matrix for only the first 4 numbers of the encrypted message
    % matrix, so we can determine the determinant later. We put it here
    % instead of in the code above for de encrypted message matrix, because
    % this for-loop will only loop 4 times anyways (known_word is 4
    % letters), and we want a square matrix to calculate the determinant.
    en_mess_mat4(1:2, count) = [en_mess_num(i);en_mess_num(i+1)];
    count = count+1;
end
%% calculate D
%Calculating the decyphering key which will be used to convert the
%(nonsense) code to plaintext.

%Calculating the determinant of the first four numbers of the encrypted
%message matrix.
den_mess_mat = det(en_mess_mat4); 

%The modular inverse of a matrix A: mod(inv(A) * det(A) * 
% multiplicative_inverse(det(A)), length(alphabet))
[~,ModMultInv] = multinverse(mod(den_mess_mat,26),26);
en_mess_mat_inv = round(mod(inv(en_mess_mat4) * den_mess_mat * ModMultInv, 26));

%Calculating the decyphering key D, by multiplying the known word matrix by
%the inverse of the matrix which represents the first four letters in the
%encrypted message.
D = mod(known_word_mat*en_mess_mat_inv,26);

%% Converting the encrypted message to plaintext 
%Using the decyphering key (D) to decypher the encrypted message (en_mess_mat)
message_NR = mod(D*en_mess_mat,26);
%Converting matrix to row vector
message_NR = message_NR(:)';
%Converting the series of numbers in the row vector to letters to return a
%plaintext.
decrypted_mess = numberToLetter(message_NR);
end

