clear all; clc;close all;

nx=256;ny=256;nz=256;

fid0=fopen('/net/kong/li/1/wxw120130/Abs_2_3D/3D_Elas_stg_cpml_wenlong/data_demo/dif/snap_all_vpz1','r');
x0=fread(fid0,nx*ny*nz,'float32');
% fid10=fopen('/net/kong/li/1/wxw120130/Abs_2_3D/3D_Elas_stg_cpml_wenlong/data_demo/dif/snap_all_vpz1','r');
% x1=fread(fid10,nx*ny*nz,'float32');

fid1=fopen('/net/kong/li/1/wxw120130/Abs_2_3D/3D_Elas_stg_cpml_wenlong/data_demo/dif/snap_all_vx_pv1','r');
x1=fread(fid1,nx*ny*nz,'float32');

fid2=fopen('/net/kong/li/1/wxw120130/Abs_2_3D/3D_Elas_stg_cpml_wenlong/data_demo/dif/snap_all_vy_pv1','r');
y1=fread(fid2,nx*ny*nz,'float32');

fid3=fopen('/net/kong/li/1/wxw120130/Abs_2_3D/3D_Elas_stg_cpml_wenlong/data_demo/dif/snap_all_vz_pv1','r');
z1=fread(fid3,nx*ny*nz,'float32');

x_o=zeros(nx,ny,nz);
y_o=zeros(nx,ny,nz);
z_o=zeros(nx,ny,nz);
x_0=zeros(nx,ny,nz);
snap=zeros(nx,ny);

dh=0.02;
yslice=[150*dh];
xslice=[150*dh];
zslice=[150*dh];

for i=1:nx
    i
    for j=1:ny
        for k=1:nz
            index=k+(j-1)*nz+(i-1)*ny*nz;

                x_0(i,j,k)=-x0(index);
                x_o(i,j,k)=-x1(index);
                y_o(i,j,k)=-y1(index);
                z_o(i,j,k)=-z1(index);
                
       end
    end
end

 hFig = figure(1);
 set(hFig, 'Position', [200 200 800 600]);

[x,y,z]=meshgrid(0:dh:255*dh,0:dh:255*dh,0:dh:255*dh);
slice(x,y,z,x_0,xslice,yslice,zslice); hold on;
set(findobj(gca,'Type','Surface'),'EdgeColor','none');
% reverse z-axis
set(gca,'zdir','reverse');
% clip the data
caxis([-1e-4,1e-4]); % one shot
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


spc=15;
Agrd=0:spc*dh:256*dh;
A=1:spc:256;
[Y,X,Z]=meshgrid(Agrd,Agrd,Agrd);

q=quiver3(X,Y,Z,x_o(A,A,A),y_o(A,A,A),z_o(A,A,A));
q.Color='black';
q.LineWidth=2;

%%%single snaps
% idx=zslice/dh
% snap=reshape(x_0(:,:,idx),nx,ny);
% snap1=reshape(x_o(:,:,idx),nx,ny);
% snap2=reshape(y_o(:,:,idx),nx,ny);

% idx=yslice/dh;
% snap=reshape(x_0(:,idx,:),nx,nz);
% snap1=reshape(x_o(:,idx,:),nx,nz);
% snap2=reshape(z_o(:,idx,:),nx,nz);

idx=xslice/dh;
snap=reshape(x_0(idx,:,:),ny,nz);
snap1=reshape(y_o(idx,:,:),ny,nz);
snap2=reshape(z_o(idx,:,:),ny,nz);

[Y1,X1]=meshgrid(Agrd,Agrd);
iFig=figure;
 set(iFig, 'Position', [200 200 600 600]);
imagesc(Agrd,Agrd,snap);hold on;
colormap (T);caxis([-1e-4,1e-4]); % one shot

q1=quiver(X1,Y1,snap1(A,A),snap2(A,A));
q1.Color='black';
q1.LineWidth=2;
%xlabel('X Position (km)','fontsize',16,'fontname','arial');
xlabel('Y Position (km)','fontsize',16,'fontname','arial');
ylabel('Z Depth (km)','fontsize',16,'fontname','arial');
set(findall(gcf,'type','axes'),'fontsize',16,'fontname','arial');
set(findall(gcf,'type','text'),'fontSize',16,'fontname','arial');


