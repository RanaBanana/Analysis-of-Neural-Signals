function [x] = numberToLetter3(v)
% This function converts an integer within Z29 to a character.
% Input: an integer within Z37
% Output: the corresponding characters  

for i = 1: length(v)
        if v(i)==36
            x(i) = char(46);        %'.'
        elseif and(v(i)>25, v(i)<37)
            x(i) = char(v(i)+22);
        elseif and(v(i)>-1, v(i)<26)
            x(i) = char(v(i)+65);             
        else
            error("Incorrect input. Please only input integers within Z29")
        end
end
end