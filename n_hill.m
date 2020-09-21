function [encrypted_mess] = n_hill(known_word, alphabet, plaintext)

%% 1. Inputs
%known_word is the word for the Hill cypher.
%alphabet is a string of the chosen alphabet used in the cypher.
%plaintext is the plaintext string to encrypt.

%m is the length of the alphabet.
m = length(alphabet);
% Key matrix size
n = sqrt(known_word);

%% 2. Create a number matrix of the plaintext message and the known word
% Convert a string of letters to their corresponding number, to make it so 
% that each letter has a corresponding number (0-25). 
plaintext_num = letterToNumber2(plaintext);
known_word_num = letterToNumber2(known_word);

% Create a columnvector of the numbers of the input
plaintext_num = plaintext_num(:);
known_word_num = known_word_num(:);

% Preallocate a number matrix, since the number of columns will be unknown
% beforehand. Divided by 3 because 3 letters fit in each column.
en_mess_num_mat = zeros(n,length(plaintext)/n);
known_word_num_mat = zeros(n);

% Create a matrix of the encrypted number vector
c = 1;
for i = 1:n:length(plaintext)
    en_mess_num_mat(1:n,c)= plaintext_num([i, i+1, i+2]);
    c = c+1;
end

% Create a square matrix of the last 9 integers of the encrypted number vector
% (Will be used to calculate the determinant later).
d = 1;
for h = 1:n:length(known_word)-1
    en_mess_num_mat9(1:n, d) = plaintext_num([end-9+h, end-9+h+1, end-9+h+2]);
    d = d+1;
end

% Create a matrix of the known word number vector
b = 1;
for j = 2:n:length(known_word)-1
    known_word_num_mat(1:n,b) = known_word_num([j, j+1, j+2]);
    b = b+1;
end

%% 3. Calculate the deciphering key D
% The decyphering key which will be used to convert the (nonsense) code to 
% plaintext.

% Calculate the determinant of the first four numbers of the encrypted
% message matrix.
den_mess_mat = det(en_mess_num_mat9); 

% The modular inverse of a matrix A: mod(inv(A) * det(A) * 
% multiplicative_inverse(det(A)), length(alphabet))
[~,ModMultInv] = multinverse(mod(den_mess_mat,29),29);
en_mess_mat_inv = round(mod(inv(en_mess_num_mat9) * den_mess_mat * ModMultInv, 29));

% Calculate the decyphering key D by multiplying the known word matrix by
% the inverse of the last nine elements in the encrypted number matrix.
D = mod(known_word_num_mat*en_mess_mat_inv,29);

%% Convert the encrypted message back to plaintext 
% Use the decyphering key (D) to decypher the encrypted message (en_mess_num_mat)
message_NR = mod(D*en_mess_num_mat,29);

% Convert matrix to row vector
message_NR = message_NR(:)';

% Convert the series of numbers in the row vector to letters to return a
% plaintext.
decrypted_mess = numberToLetter2(message_NR);
