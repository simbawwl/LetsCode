function b=bandpass(a,nt,dt,flow,fhigh)

nt_old=nt;
f_max=1./dt;
a=padpow2(a);
nt=length(a);
df=f_max/nt;


%%% filter
flow_idx=flow/df;
fhigh_idx=fhigh/df;
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
for i=floor(nt/2)+1:nt
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

b_f=a_f.*mute_spt;
b=real(ifft(b_f));
b=b(1:nt_old);
% for i=1:nt
%     a=a*(-1)^i;
%     b=b*(-1)^i;
% end
% a_fft=fftshift(fft(a));
% bi_fft=fftshift(fft(imag(b)));
% b_fft=fftshift(fft(b));

end
