clear all; clc;close all;

ng=61;
naz=73;

nz=140;
%nz=100;

ng_stp=1;
naz_stp=5;

% dot product
clb_p=2e-7;
clb_s=2e-7;

str_dpt=10;

% my
% clb_p=3e-8;
% clb_s=1e-8; 

nbin=6;

flow=0.006;
fhigh=0.95;
%fid1=fopen('./over_dot/cig_p_55_75','r');
fid1=fopen('./over_my/cig_p_55_75','r');
%fid1=fopen('./over_dot_new/cig_p_55_75','r');
%fid1=fopen('./cig_p_55_75','r');


x1=fread(fid1,ng*nz*naz,'float32');
fclose(fid1);

%fid2=fopen('./over_dot/cig_s_55_75','r');
fid2=fopen('./over_my/cig_s_55_75','r');
%fid2=fopen('./over_dot_new/cig_s_55_75','r');
%fid2=fopen('./cig_s_55_75','r');


y1=fread(fid2,ng*nz*naz,'float32');
fclose(fid2);

x=zeros(naz,ng,nz);
y=zeros(naz,ng,nz);

% change date to three-dimension: azimuth; incident; depth
for j=1:ng
    for i=1:naz
        for k=str_dpt:nz
            index=k+(i-1)*nz+(j-1)*naz*nz;
            x(i,j,k)=-x1(index);
            y(i,j,k)=-y1(index);          
        end
    end
end


% define new Red-White-Blue colormap
R = [linspace(1,1,64),linspace(1,0,64)];
G = [linspace(0,1,64),linspace(1,0,64)];
B = [linspace(0,1,64),linspace(1,1,64)];
T = [B', G', R'];


%test bining: incident, depth, azimuth
test1=zeros(ng*2-1,nz,nbin);
test2=zeros(ng*2-1,nz,nbin);

ctfp=4;
ctfs=2;


    for j=1:ng
    for k=1:nz
        for q=1:nbin
            for i=round((q-1)*180/nbin/naz_stp)+1:round(q*180/nbin/naz_stp)+1
%                 if j == 1 
%                     test1(ng,k,q)=test1(ng,k,q)+(x(i,j,k)+x(i+180/naz_stp,j,k))/2.;
%                     test2(ng,k,q)=test2(ng,k,q)+(y(i,j,k)+y(i+180/naz_stp,j,k))/2.;
%                 
%                 else
                    %if j+ng-ctfp > ng
                    test1(j+ng-ctfp,k,q)=test1(j+ng-ctfp,k,q)+x(i,j,k);
                    %end
                    test2(j+ng-ctfs,k,q)=test2(j+ng-ctfs,k,q)+y(i,j,k);
                    %if ng+ctfp-j <ng
                    test1(ng-j+ctfp,k,q)=test1(ng-j+ctfp,k,q)+x(i+180/naz_stp,j,k);
                    %end
                    test2(ng-j+ctfs,k,q)=test2(ng-j+ctfs,k,q)+y(i+180/naz_stp,j,k);   
%                 end

            end
        end
    end
%     for q=1:nbin
% %     test1(j,:,q)=bandpass(test1(j,:,q),nz,10,flow,fhigh);
% %     test2(j,:,q)=bandpass(test2(j,:,q),nz,10,flow,fhigh);    
%      test1(j,:,q)=filtf(test1(j,:,q),(1:nz)*0.001,[10 15],[25 30]);
%      test2(j,:,q)=filtf(test2(j,:,q),(1:nz)*0.001,[10 15],[25 30]);  
%     end
    end

    % smoothing
sml=4; 
%smli=3;
x2=test1;
y2=test2;
for k=1:nz
    for i=1:nbin
        for j=sml+1:2*ng-1-sml    
            x2(j,k,i)=0.;
            y2(j,k,i)=0.;
            for smi=j-sml:j+sml
            x2(j,k,i)=x2(j,k,i)+test1(smi,k,i);
            y2(j,k,i)=y2(j,k,i)+test2(smi,k,i);    
            end
            x2(j,k,i)=x2(j,k,i)/(2*sml+1);
            y2(j,k,i)=y2(j,k,i)/(2*sml+1);
        end
        
%         for j=ng-sml:ng+sml    
%             y2(j,k,i)=0.;
%             for smi=j-smli:j+smli
%             y2(j,k,i)=y2(j,k,i)+test2(smi,k,i);    
%             end
%             y2(j,k,i)=y2(j,k,i)/(2*smli+1);
%         end        
    end
end
test1=x2;
test2=y2;

h=0.025;
icd_gle=linspace(-ng,ng,2*ng-1);
dpth=linspace(0,(nz-1)*h,nz);
hfig=figure;
set(hfig, 'Position',[0,0,1400,900]);

ang=50;
 
for q=1:nbin
    
test1_=zeros(ng*2-1,nz);
test2_=zeros(ng*2-1,nz);

for j=1:2*ng-1
    for k=1:nz
    test1_(j,k)=test1(j,k,q);%/(cos((j-ng)/180.0*pi)+0.001);
    test2_(j,k)=test2(j,k,q);%/(cos((j-ng)/180.0*pi)+0.001);
    end
   test1_(j,:)=bandpass(test1_(j,:),nz,h*1000,flow,fhigh);% dot product -
   test2_(j,:)=bandpass(test2_(j,:),nz,h*1000,flow,fhigh);
 
end
subplot(2,nbin,q)
imagesc(icd_gle,dpth,test1_');title('PP-ADCIG');caxis([-clb_p, clb_p]);xlabel('Incident angle (degree)');ylabel('Depth (km)');
axis([-ang,ang,20*h,(nz-1)*h]);

subplot(2,nbin,q+nbin)
imagesc(icd_gle,dpth,test2_');title('PS-ADCIG');caxis([-clb_s, clb_s]);xlabel('Incident angle (degree)');ylabel('Depth (km)');
axis([-ang,ang,20*h,(nz-1)*h]);
end
colormap(flipud(gray));

%test; show azimuth angle gather
print -painters -depsc over_cig.eps 
epsclean('over_cig.eps'); % cleans and overwrites the input file
test3=zeros(naz,nz);
test4=zeros(naz,nz);


%     for j=1:naz
%     for k=1:nz
%         for i=1:ng
%         test3(j,k)=test3(j,k)+x(j,i,k);
%         test4(j,k)=test4(j,k)+y(j,i,k);
%         end
%     end
%       %test3(j,:)=bandpass(test3(j,:),nz,10,flow,fhigh);
%       %test4(j,:)=bandpass(test4(j,:),nz,10,flow,fhigh);
%     end
% 
% azm_gle=linspace(-180,180,naz);
% hfig=figure;
%  set(hfig, 'Position',[50,50,500,500]);
%  clb_p=clb_p*10; clb_s=clb_s*10;
% 
% subplot(1,2,1)
% imagesc(azm_gle,dpth,test3');title('PP-ADCIG');caxis([-clb_p, clb_p]);xlabel('Azimuth angle (degree)');ylabel('Depth (km)');
% subplot(1,2,2)
% imagesc(azm_gle,dpth,test4');title('PS-ADCIG');caxis([-clb_s, clb_s]);xlabel('Azimuth angle (degree)');
% colormap(flipud(gray));







