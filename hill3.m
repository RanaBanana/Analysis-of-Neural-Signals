
%% 1. Inputs

% Encrypted message
en_mess = 'OVXVTIBVHQFYWTYHCTKW?AMR';

% Known decrypted word (of the last 10 characters of the encrypted message)
known_word = 'AMSTERDAM.';

% Key matrix size
size_m = 3;

%% 2. Create a number matrix of the encrypted message and the known word
% Convert a string of letters to their corresponding number, to make it so 
% that each letter has a corresponding number (0-25). 
en_mess_num = letterToNumber2(en_mess);
known_word_num = letterToNumber2(known_word);

% Create a columnvector of the numbers of the input
en_mess_num = en_mess_num(:);
known_word_num = known_word_num(:);

% Preallocate a number matrix, since the number of columns will be unknown
% beforehand. Divided by 3 because 3 letters fit in each column.
en_mess_num_mat = zeros(size_m,length(en_mess)/size_m);
known_word_num_mat = zeros(size_m);

% Create a matrix of the encrypted number vector
c = 1;
for i = 1:size_m:length(en_mess)
    en_mess_num_mat(1:size_m,c)= en_mess_num([i, i+1, i+2]);
    c = c+1;
end

% Create a square matrix of the last 9 integers of the encrypted number vector
% (Will be used to calculate the determinant later).
d = 1;
for h = 1:size_m:length(known_word)-1
    en_mess_num_mat9(1:size_m, d) = en_mess_num([end-9+h, end-9+h+1, end-9+h+2]);
    d = d+1;
end

% Create a matrix of the known word number vector
b = 1;
for j = 2:size_m:length(known_word)-1
    known_word_num_mat(1:size_m,b) = known_word_num([j, j+1, j+2]);
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


