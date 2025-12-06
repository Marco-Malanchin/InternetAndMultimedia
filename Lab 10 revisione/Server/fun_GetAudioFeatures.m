function [FFeatures] = fun_GetAudioFeatures(W,Nfeatures)
%FUN_GETAUDIOFEATURES Summary of this function goes here
%   Detailed explanation goes here

[m,k] = size(W);

% Trasformata di ogni colonna
w = zeros(m,k);

for i = 1:k
    a = W(:,i);
    A = fft(a);
    w(:,i) = A;
end

% power spectrum
PS = zeros(m, k);

for i = 1:k
    for j = 1:m
        PS(j,i) = abs(w(j,i))^2;
    end
end

% vado a prendere i massimi
FFeatures = zeros(Nfeatures,k);

% creo la variabile con cui andare a sostuire poi i massimi
Min = min(min(PS));
Max = Min;
pos = 0;

for i = 1:k
    for a = 1:Nfeatures
        for j = 1:m
            if PS(j,i) > Max
                Max = PS(j,i);
                pos = j;
            end
        end
        FFeatures(a, i) = pos;
        PS(pos,i) = Min;
        Max = Min;
    end
end