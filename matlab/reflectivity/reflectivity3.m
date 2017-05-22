clear all;clc;close all;

fid2=fopen('/net/kong/li/1/wxw120130/Proj_1_Comp/2D_VisElas_stg_damp_Feng/data_demo/layer/rfl_p1','r');
cc=fread(fid2,[501,801],'float32');
fid3=fopen('/net/kong/li/1/wxw120130/Proj_1_Comp/2D_VisElas_stg_damp_Feng/data_demo/layer/rfl_s1','r');
dd=fread(fid3,[501,801],'float32');
fid1=fopen('/net/kong/li/1/wxw120130/Proj_1_Comp/2D_VisElas_stg_damp_Feng/data_demo/layer/rfl_p2','r');
aa=fread(fid1,[501,801],'float32');
fid4=fopen('/net/kong/li/1/wxw120130/Proj_1_Comp/2D_VisElas_stg_damp_Feng/data_demo/layer/rfl_s2','r');
bb=fread(fid4,[501,801],'float32');

fclose(fid2);fclose(fid3);fclose(fid1);fclose(fid4);


% figure;
% plot(cc(230:270,400),'g');hold on;


pos=201;
r1=zeros(801,2);
r2=zeros(801,2);
for i=1:801
    h=abs(i-401)*5;
    angle(i)=atan(h/(pos-100-1)/5);
     %r1(i,1:2)=zoep(angle(i),1.15,1.25,2.5,2.6,2.1,2.3); 
     %r2(i,1:2)=zoep(angle(i),1.15,1.2,2.5,2.65,2.1,2.3);
     r1(i,1:2)=zoep(angle(i),1.15,1.35,2.5,2.65,2.1,2.3); 
     r2(i,1:2)=zoep(angle(i),1.30,1.35,2.6,2.65,2.1,2.3);
end

c1=asin(2.5/2.65)/pi*180
c2=asin(2.6/2.65)/pi*180

a=401;
b=550;
c=3;

pos=201;

hfig1=figure;
set(hfig1, 'Position',[200,200,800,400]);

r1_tmp = interp1(angle(401:end)/pi*180,real(r1((401:end),1))',1:60,'linear');
r2_tmp = interp1(angle(401:end)/pi*180,real(r2((401:end),1))',1:60,'linear');
i1_tmp = interp1(angle(401:end)/pi*180,max(abs(cc(pos-c:pos+c,401:end))),1:60,'linear');
i2_tmp = interp1(angle(401:end)/pi*180,max(abs(aa(pos-c:pos+c,401:end))),1:60,'linear');
plot(r1_tmp,'k','LineWidth',3); grid on;hold on;
plot(i1_tmp,'g*');hold on;
plot(r2_tmp,'b','LineWidth',3); grid on;hold on;
plot(i2_tmp,'r*');
%plot(cc(pos,:),'g*');



legend('Zoeppritz Equation (example 1)','PP Image Amplitude (example 1)','Zoeppritz Equation (example 2)','PP Image Amplitude (example 2)','FontSize',16,'FontName','Arial','fontWeight','normal');

axis([1 60 0 0.10]);
% axis([a b -0.06 0.06]);
%set(gca,'xtick',a:20:b,'xticklabel',1:60);
xlabel('Incident Angle (degrees)','FontSize',16,'FontName','Arial','fontWeight','normal');
ylabel('Reflection Coefficient','FontSize',16,'FontName','Arial','fontWeight','normal');
set(gca,'FontSize',16,'FontName','Arial','fontWeight','normal');
set(gca,'YTickLabel',sprintf('%1.2f|',get(gca,'YTick')));

pos=201;
hfig2=figure;
set(hfig2, 'Position',[200,200,800,400]);


r1_tmp = interp1(angle(401:end)/pi*180,real(r1((401:end),2))',1:60,'linear');
i1_tmp = interp1(angle(401:end)/pi*180,-max(abs(dd(pos-c:pos+c,401:end))),1:60,'linear');
r2_tmp = interp1(angle(401:end)/pi*180,real(r2((401:end),2))',1:60,'linear');
i2_tmp = interp1(angle(401:end)/pi*180,-max(abs(bb(pos-c:pos+c,401:end))),1:60,'linear');
plot(r1_tmp,'k','LineWidth',3);grid on;hold on;
plot(i1_tmp,'g*');hold on;
plot(r2_tmp,'b','LineWidth',3);grid on;hold on;
plot(i2_tmp,'r*');
%plot(-dd(pos,:),'g*');

legend('Zoeppritz Equation (example 1)','PS Image Amplitude (example 1)','Zoeppritz Equation (example 2)','PS Image Amplitude (example 2)','FontSize',16,'FontName','Arial','fontWeight','normal');

xlabel('X Position');ylabel('Reflection Coefficient');
axis([1 60 -0.15 0.15]);
% axis([a b -0.06 0.06]);
%set(gca,'xtick',a:20:b,'xticklabel',1:60);
xlabel('Incident Angle (degrees)','FontSize',16,'FontName','Arial','fontWeight','normal');
ylabel('Reflection Coefficient','FontSize',16,'FontName','Arial','fontWeight','normal');

set(gca,'FontSize',16,'FontName','Arial','fontWeight','normal');
set(gca,'YTickLabel',sprintf('%1.2f|',get(gca,'YTick')));


