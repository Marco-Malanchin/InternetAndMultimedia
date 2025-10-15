function s = PotImg(C,Low,High,gamma)
[a,b] = size(C);
n = 2;
for i = 1 : a
    for j = 1 : b
        C(i,j) = (C(i,j)^gamma)*n; %faccio l'elevamento a potenza valore per valore
        if C(i,j) > High %controllo se supera i valori imposti ed in caso saturo a tali valori
            C(i,j) = High;
        elseif C(i,j) < Low
            C(i,j) = Low;
        end
    end
end
s = C;