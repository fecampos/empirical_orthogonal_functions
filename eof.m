function [eof pc expvar] = eof(data,N)

[dx dy dt] = size(data);

data = reshape(data,dx*dy,dt)'; ind = find(~isnan(data(1,:))); ndata(:,:) = data(:,ind);

[nt nx] = size(ndata);

F = detrend(ndata,'constant');

R = F'*F;

[C,L,CC,~] = svds(double(R),N);

PC = F*CC;

for i = 1:N
  e(i,:) = squeeze(CC(:,i))';
  pc(i,:) = squeeze(PC(:,i))';
end

eof = NaN(dx*dy,N); eof(ind,:) = e'; eof = reshape(eof,dx,dy,N);

dsum = diag(L)./trace(L);

for i=1:N
   expvar(i)=fix((dsum(i)*100/sum(dsum))*10)/10;
end

return
