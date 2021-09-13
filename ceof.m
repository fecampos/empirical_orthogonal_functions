function [camp cpha tamp tpha expvar] = ceof(data,N)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%    code to compute first N complex empirical orthogonal functions (CEOFs)    %
%                                                                              %
% author: Fernando Campos (fcampos@igp.gob.pe)                                 %
% Description:                                                                 %
% input: data -> variable with (dim nx,ny,nt) with NaN                         %
% input: N -> number of first N modes solved (integer)                         %
%                                                                              %
% output: camp (spatial first N modes of amplitude with dimension nx ny N)     %
% output: cpha (spatial first N modes of phase with dimension nx ny N)         %
% output: tamp (first N principal components of amplitude with dimension nt N) %
% output: tpha (first N principal components of phase with dimension nt N)     %
% output: expvar (fraction of total variance explained by 1st N modes)         %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[dx dy dt] = size(data);

data = reshape(data,dx*dy,dt)'; ind = find(~isnan(data(1,:))); ndata(:,:) = data(:,ind);

[nt nx] = size(ndata);

%ndata = detrend(ndata,'constant')./repmat(std(ndata),[nt 1]);
ndata = detrend(ndata,'constant');

F = hilbert(ndata); 

[C,L,CC,~] = svds(double(F),N);

PC = F*CC;

for i = 1:N
  e(i,:) = squeeze(CC(:,i))';
  pc(i,:) = squeeze(PC(:,i))';
end

tamp = power(pc.*conj(pc),0.5);

tpha = angle(pc);

spatial_amp = power(e.*conj(e),0.5);

spatial_pha = angle(e);

camp = NaN(dx*dy,N); cpha = NaN(dx*dy,N);

camp(ind,:) = spatial_amp'; camp = reshape(camp,dx,dy,N);

cpha(ind,:) = spatial_pha'; cpha = reshape(cpha,dx,dy,N);

L = diag(L).^2;

expvar = 100*L/sum(L);

return
