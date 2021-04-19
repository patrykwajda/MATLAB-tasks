
a=ones(1,length(ys));
ts=0:dt:(length(ys)*dt);
figure(1)
plot(ts(1:1000),ys)
grid on
hold on
plot(ts(1:1000),a)
hold on
title('Wykres odpowiedzi skokowej')

xlabel('Czas [s]')
ylabel('Napięcie [V]')

[y1,t1]=max(ys);
[y2,t2]=min(ys(t1:end));
y1=y1-1;
y2=1-y2;
T=t2*2*dt;
omega=(2*pi)/T;
tlum=log(y1/y2)/(sqrt(pi^2+(log(y1/y2))^2));
wsp_tl=(omega*tlum)/sqrt(1+tlum^2);
omega0=sqrt(omega^2+wsp_tl^2);
T0=1/omega0;
l=[1];
m=[T0^2 2*tlum*T0 1];
G1=tf(l,m);

[skok]=step(G1,ts(1:1000));
plot(ts(1:1000),skok);
C2=(2*tlum*T0)/120;
L2=(T0^2)/C2;