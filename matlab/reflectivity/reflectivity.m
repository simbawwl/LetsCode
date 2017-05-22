clear all;clc;close all;
% fid=fopen('i4101','r');
% aa=fread(fid,[501,801],'float32');
% fid1=fopen('i4201','r');
% bb=fread(fid1,[501,801],'float32');
fid2=fopen('rfl_p','r');
cc=fread(fid2,[501,801],'float32');
fid3=fopen('rfl_s','r');
dd=fread(fid3,[501,801],'float32');
fid4=fopen('crsc_p','r');
ee=fread(fid4,[501,801],'float32');
fid5=fopen('crsc_s','r');
ff=fread(fid5,[501,801],'float32');
fclose(fid2);fclose(fid3);fclose(fid4);fclose(fid5);


% amplitude correction for s wave
ff=ff*1.26004/1.96364;
% wavelet inspection
figure;
plot(cc(230:270,400),'g');hold on;
plot(ee(230-1:270-1,400),'r');
legend('Vector based','Crosscorrelation');


pos=251;
r=zeros(801,2);
for i=1:801
    h=abs(i-401)*5;
    angle(i)=atan(h/(pos-100-1)/5);
%     r(i,1:2)=zoep(angle(i),1.2,1.25,2.5,2.6,2.1,2.1);
    r(i,1:2)=zoep(angle(i),0.87988,1.26004,2.0,1.96364,2.4,2.0);
end

a=401;
b=550;
c=2;

pos=251;
figure;
% plot(aa(pos,:),'r','LineWidth',3);hold on;
plot(real(r(:,1)),'k','LineWidth',3); grid on;hold on;
plot(-max(abs(cc(pos-c:pos+c,:))),'g*');hold on;
plot(-max(abs(ee(pos-c:pos+c,:))),'r+');


legend('Zoeppritz Equation','Decoupled Propagation','Divergence & Curl');

% legend('PP Reflectivity from image (SA)','PP Reflectivity from image (DP)','PP Reflectivity from image (DC)','PP Reflectivity from Zoeppritz');
axis([a b -0.4 0.4]);
% axis([a b -0.06 0.06]);
set(gca,'xtick',a:20:b,'xticklabel',round(angle(a:20:b)/pi*180));
xlabel('Incident Angle');ylabel('Reflection Coefficient');

pos=248;
figure;
% plot((bb(pos,:)),'r','LineWidth',3);hold on;
plot(real(r(:,2)),'k','LineWidth',3);grid on;hold on;
plot(-max(abs(dd(pos-c:pos+c,:))),'g*');hold on;
plot(-max(abs(ff(pos-c:pos+c,:))),'r+');

% legend('PS Reflectivity from image (SA)','PS Reflectivity from image (DP)','PS Reflectivity from image (DC)','PS Reflectivity from Zoeppritz');
legend('Zoeppritz Equation','Decoupled Propagation','Divergence & Curl');

xlabel('X Position');ylabel('Reflection Coefficient');
axis([a b -0.3 0.3]);
% axis([a b -0.06 0.06]);
set(gca,'xtick',a:20:b,'xticklabel',round(angle(a:20:b)/pi*180));
xlabel('Incident Angle');ylabel('Reflection Coefficient');


