% fun_GetAudioFeature 
% Extract features from the input vector of audio samples
% INPUT
%   chunk: vector of audio samples
%   Nfeatures: number of features to be extracted for each Window (0 -->
%   all possible features)
% OUTPUT
%   Features: matrix of features of size Nfeatures x Number of windows

function FFeatures=fun_GetAudioFeatures(WW,Nfeatures)
% determine the number of samples for each chunk from the length of Window
[NT, KT] = size(WW);

% computer the FFT for each column of "chunk" 
FC = zeros(NT, KT);
for i = 1 : KT
    FC(:, i) = fft(WW(:, i));
end

% Take only the first half of the squared module of the FFT (because of
% symmetry) 
Spectr = zeros(floor(NT/2), KT);
for i = 1 : KT
    Spectr(:, i) = abs(FC(1:floor(NT/2),i)).^2;
end

% Sort each column of spectr in descend order
OrderdSpectre = zeros(floor(NT/2), KT);
for i = 1 : KT
    OrderdSpectre(:, i) = sort(Spectr(:, i), 'descend');
end

% Extract best Nfeatures features for each column
FFeatures = zeros(Nfeatures, KT);
for i = 1 : KT
    FFeatures(:, i) = OrderdSpectre(1:Nfeatures, i);
end