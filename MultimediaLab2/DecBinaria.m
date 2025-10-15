function g = DecBinaria(f)
[rows, cols] = size(f);
Bchar = dec2bin(f(:), 8);    % '0'/'1' , 8 perchè 256 è 2 alla 8
B = (Bchar - '0').';         % [8 x N] trasformo l'array di pixel in matrice di pixel
% 4) Rimodella nei piani di bit: [8 x rows x cols] -> [rows x cols x 8]
g = reshape(B, [8, rows, cols]);   % [8 x rows x cols]
g = permute(g, [2 3 1]);           % [rows x cols x 8]
for k = 1:8
        subplot(2,4,k);
        % Mostriamo dal più significativo (bit 7) al meno (bit 0)
        imshow(g(:,:,k), []);
        title(sprintf('Bit-plane %d', 8 - k));  % etichetta convenzionale
end
