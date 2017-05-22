% ===========================================================================
%
%            Seismogram
%
% =========================================================================

figure; 
format compact
set(gcf,'Menubar','figure','Name','Seismogram', ...
    'NumberTitle','off','Position',[10,300,550,300]);

nxrcv=170; nyrcv=170; nt=2000; 

fid=fopen('/net/kong/li/1/hxj090020/timadcigsd_salt/input/unmute_csg0001.bin','r');
s1=fread(fid,nxrcv*nyrcv*nt,'float32');

fid=fopen('/net/pkp/li/7/hxj090020/timadcig_salt/input/mute_csg0081.bin','r');
s1=fread(fid,nxrcv*nyrcv*nt,'float32');

seis = reshape(s1,[nxrcv nyrcv,nt]);

% ---- 2D test -----
testseis(1:nxrcv,1:nt)=seis(1:nxrcv,46,1:nt);
figure; imagesc(testseis)

testseis(1:nxrcv,1:nt)=seis(46,1:nyrcv,1:nt);
figure; imagesc(testseis)
% ---------------------------


set(gca,'Position',[0.15 0.15 0.6 0.7]);
[rx,ry,rt] = meshgrid(1:nxrcv,1:nyrcv,1:nt);
%figure; 
slice(rx,ry,rt,seis,[45],[45],[])
% 3 Dimential axis setting ------------
set(gca,'zdir','reverse')
set(gca,'xdir','normal')
set(gca,'ydir','reverse')
shading interp
axis([0 nxrcv 0 nyrcv 0 nt])

% color bar setting ---------------
%colormap(jet)
colormap(b2r(-3,3))
caxis([-1e-2 1e-2])
h = colorbar;
ylabel(h,'Amplitude','FontSize',14,'FontName','Helvetica','fontWeight','normal');
set(h,'YTick',[-1e-2 0 1e-2]);
set(h,'YTickLabel',['-1e-2';'0.0';'1e-2']);
view([-60 26])

pos = get(h,'position'); %it gives a position of 0.0500 2.900 1.0001
pos(1,1) = pos(1,1)+0.02;
set(h,'position',pos);
% ---------------------------------

set(gca,'XTick',[0 85 170]);
set(gca,'XTickLabel',['0.0';'1.7';'3.4']);
set(gca,'YTick',[0 85 170]);
set(gca,'YTickLabel',['0.0';'1.7';'3.4']);
set(gca,'ZTick',[0 500 1000 1500 2000]);
set(gca,'ZTickLabel',['0.0';'0.5';'1.0';'1.5';'2.0']);

title('CSG for Shot#81','FontSize',14,'FontName','Helvetica','fontWeight','bold');
xlabel('Receiver y (km)','FontSize',14,'FontName','Helvetica','fontWeight','normal'); 
ylabel('Receiver x (km)','FontSize',14,'FontName','Helvetica','fontWeight','normal');
zlabel('Time (s)','FontSize',14,'FontName','Helvetica','fontWeight','normal');

%# enable light, set transparency
%camlight left; lighting phong; alpha(0.5)
%camlight headlight; lighting phong; alpha(0.5)
%# use perspective projection
%camproj perspective 


% font size setting ---------------------
set(gca,'FontSize',14,'FontName','Helvetica','fontWeight','normal')

