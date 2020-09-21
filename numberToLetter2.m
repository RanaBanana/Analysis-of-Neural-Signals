function [x] = numberToLetter2(v)
% This function converts an integer within Z29 to a character.
% Input: a (number of) integer(s) within Z29
% Output: the corresponding characters  

for i = 1: length(v)
        if v(i)==26
            x(i) = char(46);        %'.'
        elseif v(i)==27
            x(i) = char(63);        %'?'
        elseif v(i)==28
            x(i) = char(32);        %' '
        elseif and(v(i)>-1, v(i)<26)
            x(i) = char(v(i)+65);           
        else
            error("Incorrect input. Please only input integers within Z29")
        end
end
end