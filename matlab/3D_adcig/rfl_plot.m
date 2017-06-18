clc;clear all;%close all;
nx=256;ny=256;nz=256;

fid1=fopen('rfl_p','r');
x1=fread(fid1,nx*ny*nz,'float32');
fclose(fid1);
u=zeros(nx,ny,nz);
for j=1:ny
    for i=1:nx
        for k=1:nz
            index=k+(i-1)*nz+(j-1)*nz*nx;
            u(i,j,k)=x1(index);
        end
    end
end
clear x1;

h=0.005;

[x,y,z]=meshgrid(0:h:(nx-1)*h,0:h:(ny-1)*h,0:h:(nz-1)*h);
yslice=[128*h];
xslice=[128*h];
zslice=[];

%%% the majac of slice plot
hfig=figure;
% define position & ratio of figure
set(hfig, 'Position',[100,100,900,700]);

slice(x,y,z,u,xslice,yslice,zslice); 
% take off grid lines
set(findobj(gca,'Type','Surface'),'EdgeColor','none');
% reverse z-axis
set(gca,'zdir','reverse');
% clip the data
caxis([-5e-2,5e-2]); % one shot
%caxis([-0.5,0.5]); % 8 shots
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
axis([0,1.5,0,1.5,0,1.5])
% add axis labels
xlabel('X Position (km)');
ylabel('Y Position (km)');
zlabel('Z Depth (km)');

% set font name and size
set(findall(gcf,'type','axes'),'fontsize',16,'fontname','arial');
set(findall(gcf,'type','text'),'fontSize',16,'fontname','arial');

colorbar('northoutside');

