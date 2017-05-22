clc; clear all; close all;

fid=fopen('source.bin','r');
a=fread(fid,'float32');
fclose(fid);

a=a(1:1001);

time_ax=0:0.0005:0.0005*1000;
freq_ax=-1000:2:1000;


b=hilbert(a);

for i=1:1000
    a=a*(-1)^i;
    b=b*(-1)^i;
end
a_fft=fftshift(fft(a));
bi_fft=fftshift(fft(imag(b)));
b_fft=fftshift(fft(b));

figure;
subplot(3,2,1);
plot(time_ax,a,'LineWidth',2);grid on;title('(a) Input seismogram');xlabel('Time (s)');caxis([-1,1]);
subplot(3,2,2);
plot(freq_ax,abs(a_fft),'LineWidth',2);grid on;title('(b) Frequency domain');xlabel('Frequency (Hz)');xlim([-200 200]);
subplot(3,2,3);
plot(time_ax,imag(b),'r','LineWidth',2);grid on;title('(c) Data after Hilbert transform');xlabel('Time (s)');
subplot(3,2,4);
plot(freq_ax,abs(bi_fft),'LineWidth',2);grid on;title('(d) Frequency domain');xlabel('Frequency (Hz)');xlim([-200 200]);
subplot(3,2,5);
plot(time_ax,a,'LineWidth',2);hold on;plot(time_ax,imag(b),'r','LineWidth',2);grid on;title('(e) Complex seismogram');xlabel('Time (s)');
subplot(3,2,6);
plot(freq_ax,abs(b_fft),'LineWidth',2);grid on;title('(f) Frequency domain');xlabel('Frequency (Hz)');xlim([-200 200]);


set(findall(gcf,'type','axes'),'fontsize',16,'fontname','arial');
set(findall(gcf,'type','text'),'fontSize',16,'fontname','arial');
