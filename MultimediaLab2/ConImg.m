function g = ConImg(f,m,E)
[a,b] = size(f);
for i = 1 : a
    for j = 1 : b
        f(i,j) = 1/(1+(m/(f(i,j) + eps))^E);
    end
end
g = f;