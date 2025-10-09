function g=NegImg(C,L)
[a,b] = size(C);
for i = 1 : a
    for j = 1 : b
        C(i,j) = L - 1 - C(i,j);
    end
end
g = C;
