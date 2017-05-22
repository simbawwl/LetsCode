clc;clear all;close all;
nx=301;ny=301;nt=1801;


fid1=fopen('/net/kong/li/1/wxw120130/Proj_1_Comp/3D_Elas_stg_cpml_wenlong/data_demo/layer/f2601','r');
x1=fread(fid1,nx*ny*nt,'float32');
u=zeros(nx,ny,nt);

% fid2=fopen('/net/kong/li/1/wxw120130/Proj_1_Comp/3D_Elas_stg_cpml_wenlong/data_demo/layer/f1201','r');
% y1=fread(fid1,nx*ny*nt,'float32');
% y=zeros(nx,ny,nt);
% 
% fid3=fopen('/net/kong/li/1/wxw120130/Proj_1_Comp/3D_Elas_stg_cpml_wenlong/data_demo/layer/f1301','r');
% z1=fread(fid1,nx*ny*nt,'float32');
% z=zeros(nx,ny,nt);


for k=1:nt
    for j=1:ny
        for i=1:nx
            index=i+(j-1)*nx+(k-1)*ny*nx;
            u(i,j,k)=x1(index);
        end
    end
end

% test=zeros(nx,nt);
% test(:,:)=u(:,150,:);
% imagesc(test);

% define 3D grids
h=0.005;
dt=0.0005;
[x,y,z]=meshgrid(0:h:300*h,0:h:300*h,0:dt:1800*dt);
xslice=[200*h];
yslice=[200*h];
zslice=[];

%%% the majac of slice plot
hfig=figure;
% define position & ratio of figure
set(hfig, 'Position',[200,200,700,800]);

slice(x,y,z,u,xslice,yslice,zslice); 
% take off grid lines
set(findobj(gca,'Type','Surface'),'EdgeColor','none');
% reverse z-axis
set(gca,'zdir','reverse');
% clip the data
caxis([-1e-6,1e-6]);
% define new Red-White-Blue colormap
R = [linspace(1,1,64),linspace(1,0,64)];
G = [linspace(0,1,64),linspace(1,0,64)];
B = [linspace(0,1,64),linspace(1,1,64)];
T = [R', G', B'];
colormap (T);
% change the background color to gray
set(gca,'Color',[0.8 0.8 0.8]);
% exchange xy axis
axis xy;
% add axis labels
xlabel('X Position (km)');
ylabel('Y Position (km)');
zlabel('Time (s)');
% set font name and size
set(findall(gcf,'type','axes'),'fontsize',16,'fontname','arial');
set(findall(gcf,'type','text'),'fontSize',16,'fontname','arial');




