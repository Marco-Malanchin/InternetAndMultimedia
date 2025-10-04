function sommaelementi = addnumbers(m)
[l,r] = size(m);
sommaelementi = 0;
for i = 1 : l
    for j = 1 : r
        sommaelementi = sommaelementi + m(i,j);
    end
end