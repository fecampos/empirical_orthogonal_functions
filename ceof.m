function [re_space pc camp cpha tamp tpha expvar] = ceof(data,N)

% [time x y] & time > x & time > y

[dx dy dt] = size(data);

data = reshape(data,dx*dy,dt)'; ind = find(~isnan(data(1,:))); ndata(:,:) = data(:,ind);

[nt nx] = size(ndata);

ndata = hilbert(ndata); 

F = detrend(ndata,'constant');

[C,L,CC,~] = svds(double(F),N);

PC = F*CC;

for i = 1:N
  e(i,:) = squeeze(CC(:,i))';
  pc(i,:) = squeeze(PC(:,i))';
end

tamp = power(pc.*conj(pc),0.5);

tpha = atan2(imag(pc),real(pc));

spatial_amp = power(e.*conj(e),0.5);

spatial_pha = atan2(imag(e),real(e));

camp = NaN(dx*dy,N); cpha = NaN(dx*dy,N); re_space = NaN(dx*dy,N);

camp(ind,:) = spatial_amp'; camp = reshape(camp,dx,dy,N);

cpha(ind,:) = spatial_pha'; cpha = reshape(cpha,dx,dy,N);

re_space(ind,:) = e'; re_space = reshape(re_space,dx,dy,N);

dsum = diag(L)./trace(L);

for i=1:N
   expvar(i)=fix((dsum(i)*100/sum(dsum))*N)/N;
end

return
