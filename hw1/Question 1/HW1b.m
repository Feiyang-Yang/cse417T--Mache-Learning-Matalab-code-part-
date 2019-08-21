nbins=10;

vmin=zeros(1,100000)
v1=zeros(1,100000)
vrand=zeros(1,100000)
for i=1:100000
    B= randi([0,1],1000,10);
    C=sum(B,2);
    vmin(:,i)=min(C);
    v1(:,i)= C(1,:);
    vr=randi([1,1000]);
    vrand(:,i)= C(vr,:);
end
vrand = vrand./10;
vmin = vmin./10;
v1 = v1./10;

subplot(2,2,1);histogram(vrand,nbins);
subplot(2,2,2);histogram(v1,nbins);
subplot(2,2,3);histogram(vmin,nbins);
