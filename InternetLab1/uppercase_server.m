clear all
disp('Server ready, waiting for connections...')
S = tcpserver(1236);

% Specify byte ordering as "Little-Endian" 
% Same setting should be applied to the client side
% S.ByteOrder = 'little-endian';

S.ConnectionChangedFcn = @funmyuc;

% Uncomment the following line to use the string-based version of the
% server. The client has to be modified accordingly, to use writeline() in
% place of write() or adding the terminator character at the end of the
% byte stream written with the write() function. 
%
% S.ConnectionChangedFcn = @funmyuc2;



