clear all; clc;close all;

naz=73;naz_stp=5;
ng=61;ng_stp=1;
nz=256;

z_depth=151;

fid1=fopen('cig_p_168_168','r');
x1=fread(fid1,ng*nz*naz,'float32');

fid2=fopen('cig_s_168_168','r');
y1=fread(fid2,ng*nz*naz,'float32');

x=zeros(naz,ng,nz);
y=zeros(naz,ng,nz);

for j=1:ng
    for i=1:naz
        for k=1:nz
            index=k+(i-1)*nz+(j-1)*naz*nz;
            x(i,j,k)=x1(index);
            y(i,j,k)=y1(index);          
        end
    end
end

% polar show
icd_gle=linspace(1,ng,ng);
xx=zeros(naz,ng);
yy=zeros(naz,ng);

xx(:,:)=x(:,:,z_depth);
yy(:,:)=y(:,:,z_depth);

%icd_gle=[1:90];
azm_gle=linspace(-pi,pi,naz);
[azm_gle,icd_gle]=meshgrid(azm_gle,icd_gle);
[x_axs,y_axs]=pol2cart(azm_gle,icd_gle);

figure;
%h1=polar([0 2*pi],[0 60]);delete h1;hold on;
surface(x_axs,y_axs,xx'), shading interp;
title('PP ADCIG');
set(gca,'XTick',[],'YTick',[])
axis square ;
% clip the data
clb=1e-5;
caxis([-clb, clb])

colormap(flipud(gray));
% set font name and size
set(findall(gcf,'type','axes'),'fontsize',16,'fontname','arial');
set(findall(gcf,'type','text'),'fontSize',16,'fontname','arial');

figure;
surface(x_axs,y_axs,yy'), shading interp
set(gca,'XTick',[],'YTick',[])
axis square ;
% clip the data
caxis([-clb, clb])
colormap(flipud(gray));
title('PS ADCIG');

% set font name and size
set(findall(gcf,'type','axes'),'fontsize',16,'fontname','arial');
set(findall(gcf,'type','text'),'fontSize',16,'fontname','arial');

%%%%%%%%%%%%%%%%%%%%





