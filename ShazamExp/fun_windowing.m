function W = fun_windowing(y,windowshape,wstep)

% make y column vector
y=reshape(y,length(y),1);

% Total number of audio samples in the clip
N = length(y);
% Number of audio samples in each window (chunk) within the clip
n = length(windowshape);

% max number of windows that can be extracted from y considering that 
% forward shifting step wstep (that is, overlapping of n-wstep samples)
kmax= ceil((N-n)/wstep + 1);
% index of the last element in the last window
Nmax = (kmax-1)*wstep+n; 

if Nmax > N % need to zero-pad y
    ye = zeros(Nmax,1);
    ye(1:length(y)) = y; 
end

W = zeros(n, kmax); 
for k=1:kmax
    range = (k-1)*wstep+1:(k-1)*wstep+n;
    W(:,k) = ye(range).*windowshape;
end