function result=zoep(alpha1,vs1,vs2,vp1,vp2,den1,den2)%alpha0 »Î…‰Ω«

beita1=asin(sin(alpha1)*vs1/vp1);%∑¥…‰∫·≤®
alpha2=asin(sin(alpha1)*vp2/vp1);%Õ∏…‰◊›≤®
beita2=asin(sin(alpha1)*vs2/vp1);%Õ∏…‰∫·≤®
a=zeros(4,4);
a(1,1)=sin(alpha1);  a(1,2)=cos(beita1);          a(1,3)=-sin(alpha2);                               a(1,4)=cos(beita2);
a(2,1)=cos(alpha1); a(2,2)=-sin(beita1);          a(2,3)=cos(alpha2);                               a(2,4)=sin(beita2);
a(3,1)=sin(2*alpha1);a(3,2)=vp1/vs1*cos(2*beita1);a(3,3)=vp1/vp2*vs2^2/vs1^2*den2/den1*sin(2*alpha2);a(3,4)=-den2/den1*vp1*vs2/vs1^2*cos(2*beita2);
a(4,1)=cos(2*beita1);a(4,2)=-vs1/vp1*sin(2*beita1);a(4,3)=-den2/den1*vp2/vp1*cos(2*beita2);           a(4,4)=-den2/den1*vs2/vp1*sin(2*beita2);
b=[-sin(alpha1),cos(alpha1),sin(2*alpha1),-cos(2*beita1)]';
R=inv(a)*b;
result=[R(1),R(2)];
end