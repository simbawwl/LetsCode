clc;clear all;close all;
nx=256;ny=256;nz=256;


fid1=fopen('src_all_vz1','r');
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
h=0.0058;
pml=10;

[x,y,z]=meshgrid(pml*h:h:(nx-1-pml)*h,pml*h:h:(ny-1-pml)*h,pml*h:h:(nz-1-pml)*h);
yslice=[128*h];
xslice=[128*h];
 zslice=[];

%%% the majac of slice plot
hfig=figure;
% define position & ratio of figure
 set(hfig, 'Position',[200,200,800,600]);
u1=u(pml+1:nx-pml,pml+1:ny-pml,pml+1:nz-pml);% remove pml
slice(x,y,z,u1,xslice,yslice,zslice); 
% take off grid lines
set(findobj(gca,'Type','Surface'),'EdgeColor','none');
% reverse z-axis
set(gca,'zdir','reverse');
% clip the data
%caxis([-0.001,0]);%spp
caxis([-0.0005,0.0005]);%vx
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
colorbar('northoutside');
% h = findobj('tag', 'Colorbar');
% pos = get(h, 'position');
% pos(1) = pos(1)+0.1;
% set(h, 'position', pos);



