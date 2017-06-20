clear all; clc;close all;

ng=61;naz=73;nz=256;

ng_stp=1;naz_stp=5;
clb=0.1;
flow=0.010;
fhigh=0.025;

%fid1=fopen('/net/kong/li/1/wxw120130/Proj_1_Comp/3D_Elas_stg_cpml_wenlong/data_demo/layer/cig_p_200_100','r');
fid1=fopen('/net/kong/li/1/wxw120130/Abs_2_3D/3D_Elas_stg_cpml_wenlong/data_demo/layer/cig_p_98_128','r');
x1=fread(fid1,ng*nz*naz,'float32');


%fid2=fopen('/net/kong/li/1/wxw120130/Proj_1_Comp/3D_Elas_stg_cpml_wenlong/data_demo/layer/cig_s_200_100','r');
fid2=fopen('/net/kong/li/1/wxw120130/Abs_2_3D/3D_Elas_stg_cpml_wenlong/data_demo/layer/cig_s_98_128','r');

y1=fread(fid2,ng*nz*naz,'float32');


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

% define new Red-White-Blue colormap
R = [linspace(1,1,64),linspace(1,0,64)];
G = [linspace(0,1,64),linspace(1,0,64)];
B = [linspace(0,1,64),linspace(1,1,64)];
T = [B', G', R'];


%test; show incident angle gather

test1=zeros(ng*2-1,nz,6);
test2=zeros(ng*2-1,nz,6);

    for j=1:ng
    for k=1:nz
        for q=1:6
            for i=(q-1)*6+1:q*6+1
               % if (j+ng-1<=naz && ng-j+1 <=naz && i+36 <=naz) 
                test1(j+ng-1,k,q)=test1(j+ng-1,k,q)+x(i,j,k);
                test2(j+ng-1,k,q)=test2(j+ng-1,k,q)+y(i,j,k);
                
                test1(ng-j+1,k,q)=test1(ng-j+1,k,q)+x(i+36,j,k);
                test2(ng-j+1,k,q)=test2(ng-j+1,k,q)+y(i+36,j,k);              
                %end
            end
        end
    end
%     test1(j,:)=bandpass(test1(j,:),nz,10,flow,fhigh);
%     test2(j,:)=bandpass(test2(j,:),nz,10,flow,fhigh);    
    end



h=0.010;
icd_gle=linspace(-ng,ng,2*ng-1);
dpth=linspace(0,(nz-1)*h,nz);
hfig=figure;
 set(hfig, 'Position',[200,200,1400,900]);
 
for q=1:6
    
test1_=zeros(ng*2-1,nz);
test2_=zeros(ng*2-1,nz);

for j=1:2*ng-1
    for k=1:nz
    test1_(j,k)=test1(j,k,q);
    test2_(j,k)=test2(j,k,q);
    end
end
subplot(2,6,q)
imagesc(icd_gle,dpth,test1_');title('PP-ADCIG');caxis([-clb, clb]);xlabel('Incident angle (degree)');ylabel('Depth (km)');
subplot(2,6,q+6)
imagesc(icd_gle,dpth,test2_');title('PS-ADCIG');caxis([-clb, clb]);xlabel('Incident angle (degree)');
end
colormap(flipud(gray));

%test; show azimuth angle gather

test3=zeros(naz,nz);
test4=zeros(naz,nz);



    for j=1:naz
    for k=1:nz
        for i=1:ng
        test3(j,k)=test3(j,k)+x(j,i,k);
        test4(j,k)=test4(j,k)+y(j,i,k);
        end
    end
%     test3(j,:)=bandpass(test3(j,:),nz,10,flow,fhigh);
%     test4(j,:)=bandpass(test4(j,:),nz,10,flow,fhigh);
    end

azm_gle=linspace(-180,180,naz);
hfig=figure;
 set(hfig, 'Position',[200,200,500,500]);
subplot(1,2,1)
imagesc(azm_gle,dpth,test3');title('PP-ADCIG');caxis([-clb, clb]);xlabel('Azimuth angle (degree)');ylabel('Depth (km)');
subplot(1,2,2)
imagesc(azm_gle,dpth,test4');title('PS-ADCIG');caxis([-clb, clb]);xlabel('Azimuth angle (degree)');
colormap(flipud(gray));


% 
% xx=zeros(naz,ng);
% yy=zeros(naz,ng);
% 
% xx(:,:)=x(:,:,75);
% yy(:,:)=y(:,:,75);
% 
% %icd_gle=[1:90];
% azm_gle=linspace(0,2*pi,naz);
% [azm_gle,icd_gle]=meshgrid(azm_gle,icd_gle);
% [x_axs,y_axs]=pol2cart(azm_gle,icd_gle);
% 
% 
% figure;
% h1=polar([0 2*pi],[0 ng]);delete h1;hold on;
% surface(x_axs,y_axs,xx'), shading interp;
% 
% set(gca,'XTick',[],'YTick',[])
% axis square ;
% % clip the data
% caxis([-0.1,0.1]);
% % define new Red-White-Blue colormap
% colormap(T);
% %colormap(flipud(gray));
% % set font name and size
% set(findall(gcf,'type','axes'),'fontsize',16,'fontname','arial');
% set(findall(gcf,'type','text'),'fontSize',16,'fontname','arial');
% 
% figure;
% h2=polar([0 2*pi],[0 ng]);delete h2;hold on;
% surface(x_axs,y_axs,yy'), shading interp
% set(gca,'XTick',[],'YTick',[])
% axis square ;
% % clip the data
% caxis([-0.1,0.1]);
% % define new Red-White-Blue colormap
% colormap(T);
% %colormap(flipud(gray));
% 
% % set font name and size
% set(findall(gcf,'type','axes'),'fontsize',16,'fontname','arial');
% set(findall(gcf,'type','text'),'fontSize',16,'fontname','arial');

%%%%%%%%%%%%%%%%%%%%





