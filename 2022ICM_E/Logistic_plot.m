x=0:5:50;
y=10.9055./(1+7.1800.*exp(-0.197.*x));
c0=[30.9055,20.1800,-0.0197];
fun=inline('c(1)./(1+c(2).*exp(-c(3).*x))','c','x');
b=nlinfit(x,y,fun,c0);
t=0:50;
hold on
plot(x,y,'rs',t,fun(b,t),'b');set(gca,'ygrid','on');
legend("真实值","原函数")