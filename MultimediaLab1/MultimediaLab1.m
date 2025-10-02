A = [1 2 3; 4 5 6; 7 8 9]; %il punto e virgola non fa stampare nella command window il contenuto della variabile
B = zeros(2,3); %matrice di due vettori a 3 componenti tutti messi a 0
C = ones(3,2); %matrice 3x2 con tutti 1
D = eye(3,3); %matrice identita
E = magic(4); %stampa una matrice con tutti i numeri interi da 1 a n^2 colonne e diagonali hanno sempre la stessa somma
magic(6);
x = ans; %quando una variable non viene assegnata, si assena automaticamente ad "ans"
[m, n] = size(B);% m prende il numero di vettori di B, n prende il numero di elementi nei vettori di B
[x] = sum(A); %somma le colonne
[y] = sum(sum(A));% somma tutti gli elementi della matrice
transposta = A'; %l'apostrofo fa la transposta della matrice
f = [-.5 .1 .5];
round(f); %approssima all intero piu vicino
fix(f);
ceil(f);
floor(f);%guarda il pdf per le cose mancanti
a = [1 0 1 0];
b = [1 1 0 0];
a == b; % controlla ogni elemento dei vettori e restituisce per ogni coppia 1 se sono uguali e 0 se sono diversi
~a; %restituisce il negato
a & b; %AND dei vettori
a | b; %OR dei vettori
Z = [1 4 3 2 5];
I = find(Z < 4);% restituisce gli ndici degli elementi che soddisfano la condizione
F = A(1:2 , 2:3);%restituisce gli elementi 2 e 3 dei primi due vettori della matrice A
G = A(1:2, :);%se non metti niente nei due punti, prende tutti gli indici o della colonna o della riga
%guarda il file per ogni trick sul sostituire o copiare elementi in varie matrici
