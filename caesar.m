function [v] = caesar(x,m) 
%This function encrypts and decrypts a plaintext message (x) by using caesar's
%cypher. 
% x = input message
% m = amount of positions characters are rotated to the right.  

%Converting the input to upper case letters (this happens inside the function
%letterToNumber) and 
x = letterToNumber(x); 
new_letters= mod(x+m,26);
v = numberToLetter(new_letters);
end
