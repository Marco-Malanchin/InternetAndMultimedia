function s = PotImg(C,Low,High,gamma)
[a,b] = size(C);
n = 2;
for i = 1 : a
    for j = 1 : b
        C(i,j) = (C(i,j)^gamma)*n;
        if C(i,j) > High
            C(i,j) = High;
        elseif C(i,j) < Low
            C(i,j) = Low;
        end
    end
end
s = C;