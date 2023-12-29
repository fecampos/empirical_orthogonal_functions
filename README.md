# Empirical Orthogonal Functions in Matlab (now a jupyter notebook version)

Matlab functions to compute the empirical orthogonal function (EOF) and its complex version (CEOF).

# Getting started eof.m:

```MATLAB
clear all; close all; clc

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% code to compute 15 first modes of EOF from monthly data %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

xi = ncread('input.nc','data');

lon = ncread('input.nc','longitude');

lat = ncread('input.nc','latitude');

[yy xx] = meshgrid(lat,lon);

time = double(datenum('2000-01-15')+ncread('input.nc','time')*30);

[eof pc expvar] = eof(xi,15);

figure;

subplot(5,1,[1 2 3 4]); pcolor(xx,yy,squeeze(eof(:,:,1))); shading interp; colormap jet; caxis([-1 1]*0.5);

title('1^{st} EOF of data')

subplot(5,1,5); plot(time,pc(1,:)); datetick('x','yyyy')

title('1^{st} PC of data')

```
![alt text](https://github.com/fecampos/empirical_orthogonal_functions/blob/main/eof_example.png)

# Getting started ceof.m:

```MATLAB
clear all; close all; clc

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% code to compute 15 first modes of EOF from monthly data %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

xi = ncread('input.nc','data');

lon = ncread('input.nc','longitude');

lat = ncread('input.nc','latitude');

[yy xx] = meshgrid(lat,lon);

time = double(datenum('2000-01-15')+ncread('input.nc','time')*30);

[camp cpha tamp tpha expvar] = ceof(xi,15);


figure;
subplot(5,2,[1 3 5 7]); pcolor(xx,yy,squeeze(camp(:,:,1))); shading interp; colormap jet; caxis([-1 1]*0.5); colorbar
title('1^{st} amplitude of CEOF from data')
subplot(5,2,[2 4 6 8]); pcolor(xx,yy,squeeze(cpha(:,:,1))); shading interp; colormap jet; caxis([-1 1]*pi); colorbar
title('1^{st} phase of CEOF from data')

subplot(5,2,9); plot(time,tamp(1,:)); datetick('x','yyyy')
title('1^{st} amplitude of complex PC from data')
subplot(5,2,10); plot(time,tpha(1,:)); datetick('x','yyyy')
title('1^{st} phase of complex PC from data')

```
![alt text](https://github.com/fecampos/empirical_orthogonal_functions/blob/main/ceof_example.png)

