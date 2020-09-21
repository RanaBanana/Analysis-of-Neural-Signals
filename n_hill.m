function [encrypted_mess] = n_hill(key_word, alphabet, plaintext)
%% 1. Inputs
% known_word is the word for the Hill cypher.
% alphabet is a string of the chosen alphabet used in the cypher.
% plaintext is the plaintext string to encrypt.
% Input:
% key word = a word within the same alphabet as the plaintext.
% alphabet = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'ABCDEFGHIJKLMNOPQRSTUVWXYZ.? ', 
%             or 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789.'.
% plaintext = a text within the same alphabet as the key word.

% m is the length of the alphabet.
m = length(alphabet);

% Calculate key matrix size
% n is a free variable indicating the size of the square matrix encryption
% key. floor() causes the length of the known word to round down (as to not
% fill the key matrix with unnecessary zeros).
n = floor(sqrt(length(key_word)));

%% Check if key is valid. 
% Key cannot be a multiple of the alphabet or of half of the alphabet. 
if or(mod(length(key_word), m)==0, mod(length(key_word),m)==0.5*m)
    fprintf("Key word results in an invalid key. It has been adjusted by rounding down the square root of the key word length.")
elseif length(key_word)<4
    error("Key word is too small for a cipher encryption. Please enter a key word of at least 4 characters.")
end

%% Sort into the correct alphabet and create number rowvectors
% Depending on which alphabet is used, different letterToNumber functions
% are used to calculate the vectors.

if m==26
    %Z26
    plaintext_num = letterToNumber(plaintext);
    key_word_num = letterToNumber(key_word);
elseif m==29
    %Z29
    plaintext_num = letterToNumber2(plaintext);
    key_word_num = letterToNumber2(key_word);
elseif m==36
    %Z36
    plaintext_num = letterToNumber3(plaintext);
    key_word_num = letterToNumber3(key_word);
else
    error("Alphabet input length is incorrect. Please enter an alphabet of length 26, 29, or 37")
end

% Input check for when plaintext or keyword is not divisable by n. Last letter will be
% repeated. 
a = 0;
while mod(length(plaintext_num),n)~=0 
     plaintext_num(length(plaintext_num)+1) = plaintext_num(length(plaintext_num)); 
     a = a+1;
end

%% 2. Create a matrix of the plaintext message and the key word
% Preallocate a number matrix, since the number of columns will be unknown
% beforehand.
plaintext_num_mat = zeros(n,length(plaintext_num)/n);
key_word_num_mat = zeros(n);

% Create a matrix of the encrypted number vector
c = 1;
for i = 1:n:length(plaintext_num)
    plaintext_num_mat(1:n,c)= plaintext_num([i-1+(1:n)]);
    c = c+1;
end

% Create a matrix of the key word number vector
b = 1;
for j = 1:n:n^2
    key_word_num_mat(b,1:n) = key_word_num([j-1+(1:n)]);
    b = b+1;
end

%% Generate output: encrypted message
% Calculate the numbers within the alphabet corresponding to the K (for encoding) 
% multiplication.
% Convert the numbers of the output back to a row vector (using (:)') and 
% convert the row vectors back into 'words'

if m==26
    %Z26
    encryption_num = mod(key_word_num_mat*plaintext_num_mat,26);
    encrypted_mess = numberToLetter(encryption_num(:)');
elseif m==29
    %Z29
    encryption_num = mod(key_word_num_mat*plaintext_num_mat,29);
    encrypted_mess = numberToLetter2(encryption_num(:)');
elseif m==36
    %Z36
    encryption_num = mod(key_word_num_mat*plaintext_num_mat,36);
    encrypted_mess = numberToLetter3(encryption_num(:)');
else
    error("Alphabet input length is incorrect. Please enter an alphabet of length 26, 29, or 37")
end

% Subtract the added (repeated) characters from the encrypted message 
for i = 1:a
    encrypted_mess(end) = [];  
end

end