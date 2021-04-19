t=0:dt:((length(y)-1)*dt);
ts=0:dt:(length(ys)*dt);
Fu=fft(u,250000);
Fz=fft(z,250000);
Fy=fft(y,250000);
N=length(t);
a=250;
Suud=Fu.*conj(Fu);
Szzd=Fz.*conj(Fz);
Suyd=conj(Fu).*(Fy);
Szyd=conj(Fz).*(Fy);
Suzd=Fz.*conj(Fu);
Szud=Fu.*conj(Fz);
s=250;

nrprobki=ones(size(t));
for n=1:(N-1)
    nrprobki(n+1)=nrprobki(n)+1;
end

Suu=decimate(Suud,a);
Szz=decimate(Szzd,a);
Suy=decimate(Suyd,a);
Szy=decimate(Szyd,a);
Suz=decimate(Suzd,a);
Szu=decimate(Szud,a);

Suu=smooth(Suu,s);
Szz=smooth(Szz,s);
Suy=smooth(Suy,s);
Szy=smooth(Szy,s);
Suz=smooth(Suz,s);
Szu=smooth(Szu,s);


xx=linspace(nrprobki(1),nrprobki((N)/21),21000);
G1ii_b=((Szz.*Suy)-(Suz.*Szy))./((Suu.*Szz)-(Suz.*Szu));
G1ii=interp1(nrprobki(1:length(G1ii_b)),G1ii_b,xx,'pchip');

G2ii_b=((Suu.*Szy)-(Szu.*Suy))./((Suu.*Szz)-(Suz.*Szu));
G2ii=interp1(nrprobki(1:length(G2ii_b)),G2ii_b,xx,'pchip');
figure(1)

plot(G1ii(1:length(G1ii)/2))
title('Krzywa Nyquista')
xlabel('Re')
ylabel('Im')
figure(2)
plot(G2ii(1:3500))
title('Krzywa Nyquista')
xlabel('Re')
ylabel('Im')



figure(6)
plot(nrprobki(1:10500),real(G1ii(1:10500)))
hold on
plot(nrprobki(1:10500),-imag(G1ii(1:10500)))
grid on
title('Wykresy części urojonej oraz części rzeczywistej')
xlabel('Nr próbki')
ylabel('Wartość')
df=1/(dt*100000);
w11=2*pi*2875*df
w12=2*pi*2980*df
T1=1/w12
ksi1=1/2*w12/w11*(1-(w11/w12).^2)

l1_d=[1];
m1_d=[T1.^2 2*ksi1*T1 1];
g1_d=tf(l1_d,m1_d)


figure(7)
plot(nrprobki(1:length(G2ii)/2),real(G2ii(1:length(G2ii)/2)))
hold on
plot(nrprobki(1:length(G2ii)/2),-imag(G2ii(1:length(G2ii)/2)))
grid on
title('Wykresy części urojonej oraz części rzeczywistej')
xlabel('Nr próbki')
ylabel('Wartość')
w21=2*pi*0.01*2815.5*df

T2=1/w21

l2_d=[1];
m2_d=[T2 1];
g2_d=tf(l2_d,m2_d)
[skok]=step(g1_d,ts(1:1000));
figure(12)
plot(ts(1:1000),ys)
hold on
plot(ts(1:1000),skok);
title('Wykres odpowiedzi skokowej')
xlabel('Czas [s]')
ylabel('Napięcie [V]')

[skok2]=step(g2_d,t(1:21000));
figure(13)
hold on
plot(t(1:21000),skok2);
grid on
title('Wykres odpowiedzi skokowej')
xlabel('Czas [s]')
ylabel('Napięcie [V]')
xlim([0 2.1])
ylim([0 1.05])

C1=(2*ksi1*T1)/120;
L1=(T1^2)/C1;
C2=(T2)/1100;