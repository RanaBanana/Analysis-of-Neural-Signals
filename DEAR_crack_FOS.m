function [outputArg1,outputArg2] = DEAR_crack_FOS(inputArg1,inputArg2)


DEAR = [3 0 ; 4 17];
HMRZ = [7 17; 12 25];

dDEAR = det(DEAR)

a = DEAR(1,1);
b = DEAR(1,2);
c = DEAR(2,1);
d = DEAR(2,2);

DEAR_inv(1,1) = d;
DEAR_inv(1,2) = -b;
DEAR_inv(2,1) = -c;
DEAR_inv(2,2) = a;

[~,ModMultInv] = multinverse(dDEAR,26)
DEAR_inv = mod(ModMultInv*mod(DEAR_inv,26),26)

D = mod(HMRZ*DEAR_inv,26)

message_NR = mod(D*DEAR,26)
message_NR = message_NR(:)'

message_txt = numberToLetter(message_NR)

end

