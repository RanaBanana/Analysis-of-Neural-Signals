function [x] = numberToLetter(v)
% This function converts an integer within Z26 to a character.
% Input: a (number of) integer(s) within Z26
% Output: the corresponding characters  

for i = 1: length(v)
        if and(v(i)>-1, v(i)<26)
            x(i) = char(v(i)+65);           
        else
            error("Incorrect input. Please only input integers within Z29")
        end
end