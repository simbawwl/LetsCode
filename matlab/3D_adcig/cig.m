clear all; clc;close all;

ng=61;naz=73;nz=100;

ng_stp=1;naz_stp=5;
clb_p=3e-8;
clb_s=3e-8;
flow=0.010;
fhigh=0.025;

%fid1=fopen('/net/kong/li/1/wxw120130/Proj_1_Comp/3D_Elas_stg_cpml_wenlong/data_demo/layer/cig_p_200_100','r');
fid1=fopen('./layer/cig_p_50_50','r');
x1=fread(fid1,ng*nz*naz,'float32');


%fid2=fopen('/net/kong/li/1/wxw120130/Proj_1_Comp/3D_Elas_stg_cpml_wenlong/data_demo/layer/cig_s_200_100','r');
fid2=fopen('./layer/cig_s_50_50','r');

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


xx=zeros(naz,ng);
yy=zeros(naz,ng);

xx(:,:)=max(x(:,:,49:51),[],3);
yy(:,:)=max(y(:,:,49:51),[],3);

icd_gle=[0:60];
azm_gle=linspace(0,2*pi,naz);
[azm_gle,icd_gle]=meshgrid(azm_gle,icd_gle);
[x_axs,y_axs]=pol2cart(azm_gle,icd_gle);


figure;
h1=polar([0 2*pi],[0 ng]);hold on;grid off;delete h1;
surface(x_axs,y_axs,xx'); shading interp;
% h = findall(gcf,'type','line');h(h == h1) = [];
% t = findall(gcf,'type','text');delete(t);
delete(findall(ancestor(h1,'figure'),'HandleVisibility','off','type','line','-or','type','text'));

%set(gca,'XTick',[],'YTick',[])
axis square;
% clip the data
caxis([-clb_p,clb_p]);
%define new Red-White-Blue colormap
R = [linspace(1,1,64),linspace(1,0,64)];
G = [linspace(0,1,64),linspace(1,0,64)];
B = [linspace(0,1,64),linspace(1,1,64)];
T = [B', G', R'];
 colormap (T);
%colormap(flipud(gray));
% set font name and size
set(findall(gcf,'type','axes'),'fontsize',16,'fontname','arial');
set(findall(gcf,'type','text'),'fontSize',16,'fontname','arial');

print -painters -depsc cig_p_50_50.eps 



figure;
h2=polar([0 2*pi],[0 ng]);delete h2;hold on;
surface(x_axs,y_axs,yy'); shading interp
set(gca,'XTick',[],'YTick',[])
delete(findall(ancestor(h2,'figure'),'HandleVisibility','off','type','line','-or','type','text'));

axis square ;
% clip the data
caxis([-clb_s,clb_s]);
% define new Red-White-Blue colormap
colormap(T);
%colormap(flipud(gray));

% set font name and size
set(findall(gcf,'type','axes'),'fontsize',16,'fontname','arial');
set(findall(gcf,'type','text'),'fontSize',16,'fontname','arial');
print -painters -depsc cig_s_50_50.eps 

%%%%%%%%%%%%%%%%%%%%





