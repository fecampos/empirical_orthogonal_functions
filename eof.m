function [eof pc expvar] = eof(data,N)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%    code to compute first N empirical orthogonal functions (EOFs)    %
%                                                                     %
% author: Fernando Campos (fcampos@igp.gob.pe)                        %
% Description:                                                        %
% input: data -> variable with dim nx,ny,nt) with NaN                 %
% input: N -> number of first N modes solved (integer)                %
%                                                                     %
% output: eof (spatial first N modes with dimension nx ny N)          %
% output: PC (first N principal components with dimension nt N)       %
% output: expvar (fraction of total variance explained by 1st N modes)%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[dx dy dt] = size(data);

data = reshape(data,dx*dy,dt)'; ind = find(~isnan(data(1,:))); ndata(:,:) = data(:,ind);

[nt nx] = size(ndata);

F = detrend(ndata,'constant');

[C,L,CC,~] = svds(double(F),N);

PC = F*CC;

for i = 1:N
  e(i,:) = squeeze(CC(:,i))';
  pc(i,:) = squeeze(PC(:,i))';
end

eof = NaN(dx*dy,N); eof(ind,:) = e'; eof = reshape(eof,dx,dy,N);

L = diag(L).^2;

expvar = 100*L/sum(L);

return
