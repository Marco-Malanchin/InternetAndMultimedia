function [W] = fun_windowing(y,windowshape,step)
y = y(:);                 % forza il segnale a colonna
[a, b] = size(y); %prendo la dimensione della traccia
M = windowshape(1);%prendo il valore della finestra
rect = ones(M,1);%creo la finestra
k = ceil(a/step); %capisco di quante colonne è composta la matrice W
W = zeros(M,k); %creo la matrice W
startS = 1;
endS = startS + M - 1; %creo gli indici di campionamento
  for i = 1:k
        % Se la finestra va oltre il segnale, applica zero-padding
        if endS > a
            segment = [y(startS:end); zeros(endS - a, 1)];
        else
            segment = y(startS:endS);
        end

         % Se segment è più corto o più lungo di M, sistemalo
        if length(segment) < M
            segment = [segment; zeros(M - length(segment), 1)];
        elseif length(segment) > M
            segment = segment(1:M);
        end

        % Applica la finestra rettangolare
        W(:, i) = segment .* rect;

        % Aggiorna indici
        startS = startS + step;
        endS = startS + M - 1;
   end
end
    



