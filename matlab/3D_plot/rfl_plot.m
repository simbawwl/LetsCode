clc;clear all;close all;
nx=301;ny=301;nz=301;


fid1=fopen('/net/kong/li/1/wxw120130/Proj_1_Comp/3D_Elas_stg_cpml_wenlong/data_demo/layer/rfl_s','r');
x1=fread(fid1,nx*ny*nz,'float32');
u=zeros(nx,ny,nz);

for j=1:ny
    for i=1:nx
        for k=1:nz
            index=k+(i-1)*nz+(j-1)*nz*nx;
            u(i,j,k)=x1(index);
        end
    end
end

% test=zeros(nx,nt);
% test(:,:)=u(:,150,:);
% imagesc(test);

% define 3D grids
h=0.005;

[x,y,z]=meshgrid(0:h:300*h,0:h:300*h,0:h:300*h);
yslice=[150*h];
xslice=[150*h];
 zslice=[];

%%% the majac of slice plot
hfig=figure;
% define position & ratio of figure
% set(hfig, 'Position',[200,200,600,800]);

slice(x,y,z,u,xslice,yslice,zslice); 
% take off grid lines
set(findobj(gca,'Type','Surface'),'EdgeColor','none');
% reverse z-axis
set(gca,'zdir','reverse');
% clip the data
caxis([-1e-2,1e-2]);
% define new Red-White-Blue colormap
R = [linspace(1,1,64),linspace(1,0,64)];
G = [linspace(0,1,64),linspace(1,0,64)];
B = [linspace(0,1,64),linspace(1,1,64)];
T = [B', G', R'];
colormap (T);
% change the background color to gray
set(gca,'Color',[0.8 0.8 0.8]);
% exchange xy axis
axis xy;
% add axis labels
xlabel('X Position (km)');
ylabel('Y Position (km)');
zlabel('Z Position (km)');
% set font name and size
set(findall(gcf,'type','axes'),'fontsize',16,'fontname','arial');
set(findall(gcf,'type','text'),'fontSize',16,'fontname','arial');




