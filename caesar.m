function [v] = caesar(x,m) 
%This function encrypts and decrypts a plaintext message (x) by using caesar's
%cypher. 
% x = input message
% m = amount of positions characters are rotated to the right.  

%Converting the input to upper case letters (this happens inside the function
%letterToNumber) and assigning letters to the new numbers (resulting from 
% x+shift) within the Z26 (which is done by the mod function).
x = letterToNumber(x); 
new_letters= mod(x+m,26);
v = numberToLetter(new_letters);
end
