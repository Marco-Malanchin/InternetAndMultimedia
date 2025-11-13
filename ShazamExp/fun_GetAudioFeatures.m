function [FFeatures] = fun_GetAudioFeatures(W,Nfeatures)
[m,k] = size(w);
Wtransorm = zeros(m,k);
S = zeros(m/2, k);
for i = 1:k
    Wtransorm(:, i) = fft(W(:, i));
end
for i = 1:k
    S(:, i) = Wtransform(1:m/2, i);
end


