clear all; clc;close all;

nx=256;ny=256;nz=256;

fid1=fopen('snap_all_vx_pv1','r');
x1=fread(fid1,nx*ny*nz,'float32');

fid2=fopen('snap_all_vy_pv1','r');
y1=fread(fid2,nx*ny*nz,'float32');

fid3=fopen('snap_all_vz_pv1','r');
z1=fread(fid3,nx*ny*nz,'float32');

x_o=zeros(nx,ny,nz);
y_o=zeros(nx,ny,nz);
z_o=zeros(nx,ny,nz);
x_i=zeros(nx,ny,nz);
y_i=zeros(nx,ny,nz);
z_i=zeros(nx,ny,nz);
for i=1:nx
    i
    for j=1:ny
        for k=1:nz
            index=k+(j-1)*nz+(i-1)*ny*nz;
%             x(i,j,k)=x1(index);
%             y(i,j,k)=y1(index);
%             z(i,j,k)=z1(index);
%             if sqrt((i-128)^2+(j-128)^2+(k-128)^2)>=28 && sqrt((i-128)^2+(j-128)^2+(k-128)^2)<=76
            if((i-128)*x1(index)+(j-128)*y1(index)+(k-128)*z1(index)) <=0 
                x_o(i,j,k)=x1(index);
                y_o(i,j,k)=y1(index);
                z_o(i,j,k)=z1(index);
           else
                x_i(i,j,k)=x1(index);
                y_i(i,j,k)=y1(index);
                z_i(i,j,k)=z1(index);
            end
%             end
        end
    end
end

spc=15;
dh=0.02;
[X,Y,Z]=meshgrid(0:spc*dh:256*dh,0:spc*dh:256*dh,0:spc*dh:255*dh);

% hFig = figure(1);
% set(hFig, 'Position', [200 200 600 600]);

% colormap(gray(256));
% imagesc(0.00:0.02:5.10,0.00:0.02:5.10, v,[-0.007 0.007]);hold on;
% imagesc(0.00:0.02:5.10,0.00:0.02:5.10, v);hold on;
quiver3(Y,X,Z,x_o(1:spc:256,1:spc:256,1:spc:256),y_o(1:spc:256,1:spc:256,1:spc:256),z_o(1:spc:256,1:spc:256,1:spc:256),1,'color',[1,0,0],'linewidth',1);hold on;
quiver3(Y,X,Z,x_i(1:spc:256,1:spc:256,1:spc:256),y_i(1:spc:256,1:spc:256,1:spc:256),z_i(1:spc:256,1:spc:256,1:spc:256),1,'color',[0,1,0],'linewidth',1);
% % legend('Particle Velocity','Propagation Direction');
% xlabel('Position (km)','FontSize',20);
% ylabel('Depth (km)','FontSize',20);
% 
% set(gca,'YTickLabel',sprintf('%1.1f|',get(gca,'YTick')),'fontSize',15);
% set(gca,'XTickLabel',sprintf('%1.1f|',get(gca,'XTick')),'fontSize',15);


% %% For test
% hFig = figure(1);
% set(hFig, 'Position', [200 200 600 600]);
% spc=5;
% dh=0.02;
% [X,Y]=meshgrid(1:256,1:256);
% quiver(Y,X,x_o(:,:,128),y_o(:,:,128),1,'color',[1,0,0],'linewidth',2);

