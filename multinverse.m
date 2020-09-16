
function [ModMultInv, c] = multinverse(n,m)
% This function verifies whether a given natural number has a
% multiplicative inverse in Zm for any given modulus m. 
% Input: natural number n and a parameter m (for the modulus)
% Output: True or False based on whether the number has a mult.inv in Zm.

n = abs(round(n));

[G, C] = gcd(n,m)
if G==1         % The inverse of n(mod m) only exists if gcd(n,m)=1
    ModMultInv = mod(C,m)
    c = true;
else 
    c = false;
end

end
