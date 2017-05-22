% ===========================================================================
%
%            3D SEG/EAGE salt velocity 
%
% =========================================================================
clear
%nx=676; ny=676; nz=210;
nx=340; ny=340; nz=208;

figure; 
format compact
set(gcf,'Menubar','figure','Name','Velocity model', ...
    'NumberTitle','off','Position',[10,300,500,300]);

hFig = gcf;
set(hFig, 'Position', [10,300,550,300])

fid=fopen('/net/pkp/li/7/hxj090020/fwd3d/salt_xprofile.bin','r');
v1=fread(fid,nz*ny*nx,'float32');

temp = reshape(v1,[nz ny nx]);
for iz=1:nz
    for iy=1:ny
        for ix=1:nx
            vel(ix,iy,iz)=temp(iz,iy,ix);
        end
    end
end

set(gca,'Position',[0.15 0.15 0.6 0.7]);
[x,y,z]=meshgrid(1:nx,1:ny,1:nz); 
%figure; 
%slice(x,y,z,vel,[10 670],[10 670],[10:40:210])
slice(x,y,z,vel,[325],[350],[])
% 3 Dimential axis setting ------------
set(gca,'zdir','reverse')
set(gca,'xdir','normal')
set(gca,'ydir','reverse')
shading interp
axis([0 nx 0 ny 0 nz])
axis([325 675 1 350 0 nz])

% color bar setting ---------------
%colormap(jet)
colormap(b2r(-3,3))
caxis([1500 4500])
h = colorbar;
ylabel(h,'velocity (km/s)','FontSize',14,'FontName','Helvetica','fontWeight','normal');
set(h,'YTick',[2000 2500 3000 3500 4000 4500]);
set(h,'YTickLabel',['2.0';'2.5';'3.0';'3.5';'4.0';'4.5']);
view([-60 26]);

pos = get(h,'position'); %it gives a position of 0.0500 2.900 1.0001
pos(1,1) = pos(1,1)+0.02;
set(h,'position',pos);
% ---------------------------------
set(gca,'XTick',[0 200 400 600]);
set(gca,'XTickLabel',['0.0';'2.0';'4.0';'6.0']);
set(gca,'YTick',[0 200 400 600]);
set(gca,'YTickLabel',['0.0';'2.0';'4.0';'6.0']);
set(gca,'ZTick',[0 100 210]);
set(gca,'ZTickLabel',['0.0';'1.0';'2.0']);

title('Velocity model','FontSize',14,'FontName','Helvetica','fontWeight','bold');
xlabel('Horitonal y (km)','FontSize',14,'FontName','Helvetica','fontWeight','normal'); 
ylabel('Horitonal x (km)','FontSize',14,'FontName','Helvetica','fontWeight','normal');
zlabel('Depth z (km)','FontSize',14,'FontName','Helvetica','fontWeight','normal');

%# enable light, set transparency
camlight left; lighting phong; alpha(0.5)
%camlight headlight; lighting phong; alpha(0.5)
%# use perspective projection
%camproj perspective 


% font size setting ---------------------
set(gca,'FontSize',14,'FontName','Helvetica','fontWeight','normal')

