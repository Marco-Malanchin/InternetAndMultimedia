function l = LogImg(f,c)
[a,b] = size(f);
for i = 1 : a
    for j = 1 : b
        f(i,j) = c * log(1 + f(i,j));
    end
end
l = f;