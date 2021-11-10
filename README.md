# Empirical Orthogonal Functions in Matlab
Matlab functions to compute the empirical orthogonal function (EOF) and its complex version (CEOF).

# Getting started:

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
