function addendi = sumthreshold(n)
counter = 0;
sum = 0;
while sum < n
    counter = counter + 1;
    sum = sum + rand(1);%rand genere valori casuali compresi tra 0 e 1, con rand possiamo anche generare matrici es rand(3,2)
end
addendi = counter;