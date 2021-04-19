[lm1,mm1]=th2tf(bj22221,1);
gdm1=tf(lm1,mm1,dt);
gcm1=d2c(gdm1,'tustin')
step(gcm1)
ts=0:dt:(length(ys)*dt);
hold on
plot(ts(1:1000),ys,'g')
title('Wykres odpowiedzi skokowej')

xlabel('Czas [s]')
ylabel('Napięcie [V]')