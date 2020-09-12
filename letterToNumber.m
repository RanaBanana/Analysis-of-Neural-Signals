function [v] = letterToNumber(x) 
% lower case a start at 97
x = upper(x);
if isnumeric(x)==false;
    v = double(char(x)) -65;
end
end