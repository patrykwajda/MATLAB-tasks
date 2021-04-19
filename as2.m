ysds=diff(ys); %rozniczka z syghnalu odpowiedzi skokowej
niq=fft(ysds,21000); %fourier tej rozniczki
figure(1)
plot(niq(1:21000/2))
grid on
title('Krzywa Nyquista')
xlabel('Re')
ylabel('Im')
hold on
nrprobki=zeros(size(niq));
N=length(niq)-1;
for n=1:N
    nrprobki(n+1)=nrprobki(n)+1;
end
figure(2)
plot(nrprobki(1:21000/2),real(niq(1:21000/2)))
hold on
plot(nrprobki(1:21000/2),-imag(niq(1:21000/2)))
grid on
title('Wykresy części urojonej oraz części rzeczywistej')
xlabel('Nr próbki')
ylabel('Wartość')
df=1/(dt*21000);
w1=2*pi*353*df
w2=2*pi*333*df
T0=1/w2;
ksi=abs(1/2*w2/w1*(1-(w1/w2).^2))

l2=[1];
m2=[T0^2 2*ksi*T0 1];
g2=tf(l2,m2)
figure(3)
plot(ts(1:999),ysds)
hold on
[skok]=step(g2,ts(1:1000));
imp=diff(skok);
plot(ts(1:999),imp);
grid on
title('Wykres odpowiedzi impulsowej')
xlabel('Czas [s]')
ylabel('Napięcie [V]')
C2=(2*ksi*T0)/120
L2=(T0^2)/C2