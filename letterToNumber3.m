function [v] = letterToNumber3(x) 
% This function converts a (string of) character(s) to a number within Z37.
% Input: a (number of) letter(s) (could also be a lowercase letter),
% a number or '.' (Z37).
% Output: the corresponding number(s) 

% Control for non-capitalised letters and for string ("") inputs:
x = char(upper(x));

% Preallocate a zeros vector with a length equal to that of x.
v = zeros(1,length(x));

% For-loop iterates for each element within x. It gives an error if an
% element is outside Z37.
for i = 1: length(x)
    if double(x(i))==46
        v(i) = 36;           %'.'
    elseif and(double(x(i))>47, double(x(i))<58)
        v(i) = double(char(x(i)))-22;
    elseif and(double(x(i))<91, double(x(i))>64)
        v(i) = double(char(x(i)))-65;
    else
        error("Incorrect input. Please input a (number of) letter(s), a number or '.'");      
    end
end
end