clear all; clc;close all;

ng=90;naz=361;nz=301;


fid1=fopen('/net/kong/li/1/wxw120130/Proj_1_Comp/3D_Elas_stg_cpml_wenlong/data_demo/layer/cig_p_200_100','r');
x1=fread(fid1,ng*nz*naz,'float32');


fid2=fopen('/net/kong/li/1/wxw120130/Proj_1_Comp/3D_Elas_stg_cpml_wenlong/data_demo/layer/cig_s_200_100','r');
y1=fread(fid2,ng*nz*naz,'float32');


% temp=zeros(nz,ng*naz);
% temp=reshape(x1,nz,naz*ng);
% for j=1:ng*naz
%         for k=1:nz
%             index=k+(j-1)*nz;
%             temp(k,j)=x1(index);
%        
%         end
% end
% 
% clip=0.0001;
% imagesc(temp,[-clip clip]);

x=zeros(naz,ng,nz);
y=zeros(naz,ng,nz);

for j=1:ng
    for i=1:naz
        for k=1:nz
            index=k+(i-1)*nz+(j-1)*naz*nz;
            x(i,j,k)=x1(index);
            y(i,j,k)=y1(index);          
        end
    end
end

icd_gle=[1:90];
azm_gle=linspace(0,2*pi,361);
[azm_gle,icd_gle]=meshgrid(azm_gle,icd_gle);
[x_axs,y_axs]=pol2cart(azm_gle,icd_gle);

%test
figure
test=zeros(ng,nz);
for i=1:naz
    for j=1:ng
    for k=1:nz
test(j,k)=test(j,k)+y(i,j,k);
    end
    end
end
imagesc(test);


xx=zeros(naz,ng);
yy=zeros(naz,ng);

for i=1:naz
    for j=1:ng        
        xx(i,j)=max(x(i,j,99:102));
        yy(i,j)=max(y(i,j,99:102));
    end
end

% xx(:,:)=x(:,:,109);
% yy(:,:)=y(:,:,109);
figure;
surface(x_axs,y_axs,xx'), shading interp
set(gca,'XTick',[],'YTick',[])
axis square ;
% clip the data
caxis([-0.01,0.01]);
% define new Red-White-Blue colormap
colormap(flipud(gray));

figure;
surface(x_axs,y_axs,yy'), shading interp
set(gca,'XTick',[],'YTick',[])
axis square ;
% clip the data
caxis([-0.01,0.01]);
% define new Red-White-Blue colormap
colormap(flipud(gray));

% set font name and size
set(findall(gcf,'type','axes'),'fontsize',16,'fontname','arial');
set(findall(gcf,'type','text'),'fontSize',16,'fontname','arial');



