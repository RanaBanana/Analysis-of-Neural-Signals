function [v] = letterToNumber(x) 
% This function converts a (string of) character(s) to a number within Z29.
% Input: a (number of) letter(s) (could also be a lowercase letter)
% Output: the corresponding number(s).

% Control for non-capitalised letters and for string ("") inputs:
x = char(upper(x));

% This if-statement controls for numeric input by excluding it from the
% statement.
if and(double(x)<91, double(x)>64)
    v = double(char(x))-65;
else
    error("Input incorrect. Please enter a (number of) letter(s).")
end
end