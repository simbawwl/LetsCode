clc;clear all;close all;

%source
nt=1000;
dt=0.001;
nprd=100;
for it=1:nt
    seri(it)=-2.*(it-nprd+2)*exp(-(pi*dt*(it-nprd+2)/(nprd*dt))^2);
end
FT_seri=abs(fft(seri,nt));

irelax=1;
freq_relax=[13,50,100];
ts_s=1./freq_relax/2.0/pi;
ts_p=1./freq_relax/2.0/pi;

freq_max=100;
tau=1.5;
te_p(1)=ts_p(1)*(1+tau);%0.1; 
te_p(2)=ts_p(2)*(1+tau);%0.02;
te_p(3)=ts_p(3)*(1+tau);%0.01;


sigma=0;
% Mr=0;Mi=0;
% for freq=1:freq_max
%     for i=1:1
%         omega=freq*2*pi;
%         Mr=Mr+(1+omega*omega*ts_p(i)*te_p(i))/(1+omega*omega*ts_p(i)*ts_p(i));
%         Mi=Mi+(omega*(te_p(i)-ts_p(i)))/(1+omega*omega*ts_p(i)*ts_p(i));
%     end
%     
%     Q1(freq)=(1-1+Mr)/Mi;
% end
% semilogx(1./Q1,'--r','LineWidth',2);hold on;
for freq=1:freq_max
    sigma=0.0;
    for i=1:1
        sigma=sigma+(1+complex(0,1)*freq*2*pi*te_p(i))/(1+complex(0,1)*freq*2*pi*ts_p(i));
    end
    M(freq)=1-1+sigma;
    Q1(freq)=real(M(freq))/imag(M(freq));
end
figure;
semilogx(1./Q1,'k','LineWidth',2); hold on;
% semilogx(0.01*sqrt(real(M)),'b','LineWidth',2); hold on;
ratio=max(1./Q1)/max(FT_seri(1:freq_max));
semilogx(FT_seri(1:freq_max)*ratio,'--k','LineWidth',2);
legend('1/Q','Source (scaled)');
xlabel('Frequency (Hz)','FontSize',16,'FontName','Arial','fontWeight','normal');
ylabel('1/Q','FontSize',16,'FontName','Arial','fontWeight','normal');

% set(gca,'XTickLabel',sprintf('%3.4f|',get(gca,'XTick')))
% set(gca,'YTickLabel',sprintf('%1.1f|',get(gca,'YTick')));
set(gca, 'XTickLabel',[1,10,100]);
set(gca, 'YTickLabel',['0.0';'0.1';'0.2';'0.3';'0.4';'0.5']);
%set(gca,'YTickLabel',sprintf('%1.1f|',get(gca,'YTick')));
set(gca,'FontSize',16,'FontName','Arial','fontWeight','normal');

figure;
%semilogx(real(sqrt(M)),'r','LineWidth',2);hold on;
semilogx(real(sqrt(M)),'k','LineWidth',2);hold on;
%semilogx(ones(1,freq_max),'b','LineWidth',2); 
%legend('Viscoelastic','Elastic');
set(gca, 'XTickLabel',[1,10,100]);
set(gca, 'YTickLabel',['1.0';'1.2';'1.4';'1.6';'1.8']);

xlabel('Frequency (Hz)','FontSize',16,'FontName','Arial','fontWeight','normal');
ylabel('V(f)/V','FontSize',16,'FontName','Arial','fontWeight','normal');
set(gca,'FontSize',16,'FontName','Arial','fontWeight','normal');