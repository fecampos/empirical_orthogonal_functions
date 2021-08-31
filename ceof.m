function [camp cpha tamp tpha expvar] = ceof(data,N)

% [time x y] & time > x & time > y

[dx dy dt] = size(data);

data = reshape(data,dx*dy,dt)'; ind = find(~isnan(data(1,:))); ndata(:,:) = data(:,ind);

[nt nx] = size(ndata);

ndata = detrend(ndata,'constant')./repmat(std(ndata),[nt 1]);

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
