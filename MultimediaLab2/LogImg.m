function l = LogImg(f,c)
[a,b] = size(f);
for i = 1 : a
    for j = 1 : b
        f(i,j) = c * log(1 + f(i,j)); %faccio la funzione log valore per valore dell immagine
    end
end
l = f;