clc;close all;clear all;
%fid=fopen('vp_dsp.bin','r');
fid=fopen('theta_dsp.bin','r');

nx=2100;
nz=1801;
vp=fread(fid,[nz,nx],'float32');
x1=0:6.25:(nx-1)*6.25/1000.;
z1=0:6.25:(nz-1)*6.25/1000;

figure(1);
imagesc(z1,x1,vp);colormap('gray');
xlabel('Position (km)');
ylabel('Depth (km)');
vp1=reshape(vp,nx*nz,1);

bound=50;
%val=linspace(1500,4600,10);
val=linspace(-bound,bound,11);

figure(2);
%hist(vp1(vp1>1500 & vp1<4500),val,1);
hist(vp1(vp1>-bound &  vp1<bound),val,1);

xlabel('vp (m/s)');
ylabel('count');
set(get(gca,'child'),'FaceColor','none','EdgeColor','k');
%xlim([1300 4500]);
xlim([-45 45]);

xsec=4;
nx1=floor(nx/xsec);
zsec=4;
nz1=floor(nz/zsec);
subvp=zeros(nz1,nx1,xsec*zsec);
subvp1=zeros(nz1*nx1,1);


for ixsec=1:xsec
for izsec=1:zsec
%if ixsec*nx1>nx 

subvp(:,:,(izsec-1)*xsec+ixsec)=vp((izsec-1)*nz1+1:izsec*nz1,(ixsec-1)*nx1+1:ixsec*nx1);
end
end

figure(3);
for ixsec=1:xsec*zsec
subplot(xsec,zsec,ixsec);
subvp1=reshape(subvp(:,:,ixsec),nx1*nz1,1);
%hist(subvp1(subvp1>1500 & subvp1<4500),val,1);
hist(subvp1(subvp1>-bound & subvp1<bound),val,1);

%xlabel('vp (mk/s)');
%ylabel('frequency');
set(get(gca,'child'),'FaceColor','none','EdgeColor','k');
%xlim([1300 4500]);
xlim([-45 45]);

end


