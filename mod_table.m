function [prod_table, add_table] = mod_table(m)
%   Input is m. Produces two tables, one for multiplication and one for
%   addition. The values in the tables are the modulus for every
%   calculation.

prod_table = zeros(m,m);
add_table = zeros(m,m);

for r = 1:m
    for c = 1:m
        prod_table(r,c) = mod((r-1)*(c-1),m); 
        add_table(r,c) = mod((r-1)+(c-1),m);
    end
end

prod_table
add_table
end
