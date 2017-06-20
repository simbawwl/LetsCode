clc;clear all;close all;
nx=301;ny=301;nz=187;
%nx=256;ny=256;nz=256;


fid1=fopen('./overthrust/rfl_s','r');
x1=fread(fid1,nx*ny*nz,'float32');
u=zeros(nx,ny,nz);
hh=zeros(1,nz);

% flow=0.010;
% fhigh=0.025;

 flow=0.015;
 fhigh=0.045;

for j=1:nx
    for i=1:ny
        for k=1:nz
            index=k+(i-1)*nz+(j-1)*nz*ny;
            hh(k)=x1(index);
        end
        hh=bandpass(hh,nz,5,flow,fhigh);
        for k=30:nz
            u(j,i,k)=hh(k);
        end
    end
end

% test=zeros(nx,nt);
% test(:,:)=u(:,150,:);
% imagesc(test);

% define 3D grids
h=0.005;

[x,y,z]=meshgrid(0:h:(nx-1)*h,0:h:(ny-1)*h,0:h:(nz-1)*h);
yslice=[170*h];
xslice=[170*h];
zslice=[];



%%% the majac of slice plot
hfig=figure;
% define position & ratio of figure
 set(hfig, 'Position',[100,100,800,700]);

slice(x,y,z,u,xslice,yslice,zslice); 
% take off grid lines
set(findobj(gca,'Type','Surface'),'EdgeColor','none');
% reverse z-axis
set(gca,'zdir','reverse');
% clip the data
caxis([-20,20]); % 8 shots
%caxis([-0.5,0.5]); % 1 shots
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
zlabel('Z Depth (km)');

% set font name and size
set(findall(gcf,'type','axes'),'fontsize',16,'fontname','arial');
set(findall(gcf,'type','text'),'fontSize',16,'fontname','arial');




