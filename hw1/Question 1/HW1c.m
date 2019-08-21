x = 0:0.01:0.5;
P = zeros(1,51);
for i=1:51
  B= randi([0,1],1000,10);
  C=sum(B,2);
  C=C./10;
  C=abs(C-0.5);
  C=(C-x(:,i))>0;
  C=sum(C,1);
  P(1,i)=C./1000;
end
y = 2*exp(-2*10*x.^2)
plot(x,P)
hold on
plot(x,y)
