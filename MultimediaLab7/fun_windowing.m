function [W] = fun_windowing(y,windowshape,step)
[a, b] = size(y);
M = windowshape(0);
rect = ones(M,1);
k = ceil(a/step);
W(M,k);
for i = 1:k
    



