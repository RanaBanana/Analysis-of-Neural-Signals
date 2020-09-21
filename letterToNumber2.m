function [v] = letterToNumber2(x) 
% This function converts a (string of) character(s) to a number within Z29.
% Input: a (number of) letter(s) (could also be a lowercase letter),
% '.', '?', or a space (Z29).
% Output: the corresponding number(s) 

% Control for non-capitalised letters and for string ("") inputs:
x = char(upper(x));

% Preallocate a zeros vector with a length equal to that of x.
v = zeros(1,length(x));

% For-loop iterates for each element within x. It gives an error it an
% element is outside Z29. This also controls for numeric input since these 
% are ascii 48-56 (and are excluded).
for i = 1: length(x)
    if double(x(i))==46
        v(i) = 26;              %'.'
    elseif double(x(i))==63
        v(i) = 27;              %'?'
    elseif double(x(i))==32
        v(i) = 28;              %' '
    elseif and(double(x(i))<91, double(x(i))>64)
        v(i) = double(char(x(i)))-65; 
    else
        error("Incorrect input. Please input a (number of) letter(s), '.', '?', or a space.");      
    end
end
end