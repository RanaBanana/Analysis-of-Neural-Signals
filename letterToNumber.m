function [v] = letterToNumber(x) 
% This function converts a letter to a number within Z26.
% Input: a (number of) letter(s) (could also be a lowercase letter)
% Output: the corresponding number (s)

% Control for non-capitalised letters
x = upper(x);

% This if-statement controls for numeric input by excluding it from the
% statement.
if isnumeric(x)==false;
    v = double(char(x)) -65;
end
end
