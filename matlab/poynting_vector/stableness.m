clear all; clc;

fid1=fopen('s0101','r');
h=fread(fid1,[256,256*100],'float32');


fid2=fopen('s0201','r');
v=fread(fid2,[256,256*100],'float32');

fid3=fopen('pv_s1101','r');
pvh=fread(fid3,[256,256*100],'float32');


fid4=fopen('pv_s1201','r');
pvv=fread(fid4,[256,256*100],'float32');

for num=30:30
    num
h1=h(1:256,(num-1)*256+1:num*256);
v1=v(1:256,(num-1)*256+1:num*256);
pvh1=pvh(1:256,(num-1)*256+1:num*256);
pvv1=pvv(1:256,(num-1)*256+1:num*256);


cmp1=h1(128,128:256);
cmp2=pvh1(128,128:256);

% cmp1=abs(fft(cmp1));
% cmp2=abs(fft(cmp2));

plot (cmp1,'r');hold on;
plot (cmp2,'b');hold on;

end
