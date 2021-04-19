t=0:dt:((length(y)-1)*dt);
ts=0:dt:(length(ys)*dt);
N=length(t);
Fu=fft(u,100000); %fourier
Fy=fft(y,100000);
Puu=Fu.*conj(Fu); % gestosc widmowa mocy
Puy=conj(Fu).*(Fy);

s=150;
Puu=smooth(Puu,s);
Puy=smooth(Puy,s);
a=25;

Gjw=Puy./Puu; %jako dzielenie mocy widmowych sygnalow jest wyznacozna transmitancja widmowa
figure(3)
plot(Gjw(1:length(Gjw)/2))
title('Krzywa Nyquista')
xlabel('Re')
ylabel('Im')
grid on
decGjw=decimate(Gjw,a);
figure(4)
plot(decGjw(1:length(decGjw)/2))
title('Krzywa Nyquista')
xlabel('Re')
ylabel('Im')
grid on

nrprobki=zeros(size(t));
for n=1:N
    nrprobki(n+1)=nrprobki(n)+1;
end
figure(5)
plot(nrprobki(1:length(decGjw)/2),real(decGjw(1:length(decGjw)/2)))
hold on
plot(nrprobki(1:length(decGjw)/2),-imag(decGjw(1:length(decGjw)/2)))
title('Wykres Im/Re w zależności od nr próbki')
xlabel('Nr próbki')
ylabel('Wartość')
grid on
df=1/(dt*40);
w1=2*pi*0.01*(62)*df
w2=2*pi*0.01*(66)*df

T0=1/w2;
ksi=1/2*w2/w1*(1-(w1.^2/w2.^2))

l2=[1];
m2=[T0^2 2*ksi*T0 1];
g2=tf(l2,m2)
[skok]=step(g2,ts(1:1000));
figure(1)
plot(ts(1:1000),ys)
hold on
plot(ts(1:1000),skok);
grid on
title('Wykres odpowiedzi skokowej')
xlabel('Czas [s]')
ylabel('Napięcie [V]')
C2=(2*ksi*T0)/120
L2=(T0^2)/C2
