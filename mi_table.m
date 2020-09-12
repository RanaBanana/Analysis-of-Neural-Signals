function [MI_table] = mi_table(a,m)

[G, C, o] = gcd(a,m)

for G ==1
    MI_table = mod(C,m)  
end 
end