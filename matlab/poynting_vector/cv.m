clear ; clc;

fid1=fopen('s0101','r');
h=fread(fid1,[256,256*5],'float32');


fid2=fopen('s0201','r');
v=fread(fid2,[256,256*5],'float32');

fid3=fopen('pv_s0101','r');
pvh=fread(fid3,[256,256*5],'float32');


fid4=fopen('pv_s0201','r');
pvv=fread(fid4,[256,256*5],'float32');


num=2;
h=h(1:256,(num-1)*256+1:num*256);
v=v(1:256,(num-1)*256+1:num*256);
pvh=pvh(1:256,(num-1)*256+1:num*256);
pvv=pvv(1:256,(num-1)*256+1:num*256);

medflt=7;
h=medfilt2(h,[medflt,medflt]);
v=medfilt2(v,[medflt,medflt]);
pvh=medfilt2(pvh,[medflt,medflt]);
pvv=medfilt2(pvv,[medflt,medflt]);


hv1=mean(mean(sqrt(h.^2+v.^2)));
% hv1=0.3526;
pv1=mean(mean(sqrt(pvh.^2+pvv.^2)));
% pv1=0.7575;

h=h/hv1*pv1;
v=v/hv1*pv1;

% h1=h./sqrt(h.^2+v.^2);
% v1=v./sqrt(h.^2+v.^2);
% pvh1=pvh./sqrt(pvh.^2+pvv.^2);
% pvv1=pvv./sqrt(pvh.^2+pvv.^2);

h1=h;
v1=v;
pvh1=pvh;
pvv1=pvv;

door1=pv1/1
door2=pv1*40;

for i=1:256
        for j=1:256
            if sqrt(h(i,j)^2+v(i,j)^2)<=door1 %|| sqrt(pvh(i,j)^2+pvv(i,j)^2)<=door1
                h1(i,j)=0;
                v1(i,j)=0;
                pvh1(i,j)=0;
                pvv1(i,j)=0;
            elseif sqrt(h(i,j)^2+v(i,j)^2)>=door2 % || sqrt(pvh(i,j)^2+pvv(i,j)^2)>=door2
                h1(i,j)=h1(i,j)/sqrt(h(i,j)^2+v(i,j)^2)*door2;
                v1(i,j)=v1(i,j)/sqrt(h(i,j)^2+v(i,j)^2)*door2;
                pvh1(i,j)=pvh1(i,j)/sqrt(h(i,j)^2+v(i,j)^2)*door2;
                pvv1(i,j)=pvv1(i,j)*sqrt(h(i,j)^2+v(i,j)^2)*door2; 
            end          
        end
end% feather(h(:,1:256),v(:,1:256));



spc=2;
dh=0.02;
[X,Y]=meshgrid(0:spc*dh:255*dh,0:spc*dh:255*dh);

hFig = figure(1);
set(hFig, 'Position', [200 200 600 600]);

colormap(gray);
imagesc(0.00:0.02:5.10,0.00:0.02:5.10, v,[-0.3 0.3]);hold on;
xlabel('Position (km)');
ylabel('Depth (km)');

% w=10000;
% quiver(X,Y,-w*h(1:spc:256,(num-1)*256+1:spc:(num-1)*256+256),-w*v(1:spc:256,(num-1)*256+1:spc:(num-1)*256+256),'color',[1,0,0],'linewidth',3);hold on;
quiver(X,Y,-h1(1:spc:256,1:spc:256),-v1(1:spc:256,1:spc:256),'color',[1,0,0],'linewidth',2);hold on;
% quiver(X,Y,-pvh1(1:spc:256,1:spc:256),-pvv1(1:spc:256,1:spc:256),'color',[0,1,0],'linewidth',2);
legend('Particle Velocity','Poynting Vector');