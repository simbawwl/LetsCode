clc; clear all; close all;

fid=fopen('source.bin','r');
a=fread(fid,'float32');
fclose(fid);

nt=1024;
a=a(1:nt);
dt=0.0005;
time_ax=0:dt:dt*(nt-1);
freq_ax=0:(1/dt/nt):(1/dt/nt)*(nt-1);

%%% filter
flow_idx=10;
fhigh_idx=20;
ntpp=0.5*flow_idx;
tp=pi/ntpp;
mute_spt=ones(1,nt);
for i=1:nt/2    
    if (i<=flow_idx)
        mute_spt(i)=0.5*(1.0-cos((i+ntpp-flow_idx)*tp));
    end
    if (i<=(flow_idx-ntpp))
        mute_spt(i) = 0.0;
    end
    if (i >= fhigh_idx)
        mute_spt(i) = 0.5*(1.0+cos(((i-fhigh_idx))*tp));
    end
    if (i>=fhigh_idx+ntpp)
        mute_spt(i) = 0.0;
    end
  
end
for i=nt/2+1:nt
    mute_spt(i)=mute_spt(nt-i+1);
end
a_f=fft(a);
% a_f=fftshift(a_f);
% for i=2:nt/2
%     b(i)=b(i)*2;
% end
% for i=nt/2+2:nt
%     b(i)=0;
% end
% b_f=fftshift(a_f);
b_f=a_f.*mute_spt';
b=ifft(b_f);

% for i=1:nt
%     a=a*(-1)^i;
%     b=b*(-1)^i;
% end
% a_fft=fftshift(fft(a));
% bi_fft=fftshift(fft(imag(b)));
% b_fft=fftshift(fft(b));

figure;
subplot(2,2,1);
plot(time_ax,a,'LineWidth',2);grid on;title('(a) Input seismogram');xlabel('Time (s)');caxis([-1,1]);
subplot(2,2,2);
plot(freq_ax,abs(a_f),'LineWidth',2);xlabel('Frequency (Hz)');grid on;title('(b) Frequency domain');
subplot(2,2,3);
plot(time_ax,real(b),'r','LineWidth',2);grid on;title('(c) Data after Hilbert transform');xlabel('Time (s)');
subplot(2,2,4);
plot(freq_ax,abs(b_f),'LineWidth',2);xlabel('Frequency (Hz)');grid on;title('(b) Frequency domain');
