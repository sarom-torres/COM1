#-----DESCRIÇÃO DA ATIVIDADE 27-11-2020
# Fazer um código em .m para gerar uma onda quadrada com frequência fundamental de 1kHz.

#-----SAROM TORRES

clear all; close all; clc;

f_fund = 1e3;
f_h = [3e3 5e3 7e3 9e3 11e3 13e3 15e3 17e3 19e3];

N = 100; # número de amostras
fs = N*f_fund; #frequencia de amostragem

#eixo do tempo

ts = 1/fs;
t_final = 1;
t = [0:ts:t_final];

#eixo da frequencia

passo_f = 1; 
f = [-fs/2:passo_f:fs/2];

#sinal no tempo

A_fund = 10;
A_h = A_fund*[1/3 1/5 1/7 1/9 1/11 1/13 1/15 1/17 1/19];

# onda fundmental
y_fund = A_fund*sin(2*pi*f_fund*t);

# harmônicas
y1 = A_h(1)*sin(2*pi*f_h(1)*t);
y2 = A_h(2)*sin(2*pi*f_h(2)*t);
y3 = A_h(3)*sin(2*pi*f_h(3)*t);
y4 = A_h(4)*sin(2*pi*f_h(4)*t);
y5 = A_h(5)*sin(2*pi*f_h(5)*t);
y6 = A_h(6)*sin(2*pi*f_h(6)*t);
y7 = A_h(7)*sin(2*pi*f_h(7)*t);
y8 = A_h(8)*sin(2*pi*f_h(8)*t);
y9 = A_h(9)*sin(2*pi*f_h(9)*t);

y = y_fund+y1+y2+y3+y4+y5+y6+y7+y8+y9;


#sinal na frequência
Y = fft(y);
Y = fftshift(Y);

#plots

#--------------Figura contendo a onda quadrada e o espectro de frequências (fundamenta + harmônicas)
figure(1)

subplot(211)
plot(1e3*t,y)
axis([0 3 -1.2*A_fund 1.2*A_fund])
xlabel('Tempo (ms)');
ylabel('Amplitude (V)');
title('Onda quadrada de frequência 1 kHz');

subplot(212)
plot(f/1e3,abs(Y)/length(y))
axis([-22 22 0 6])
xlabel('Frequência (kHz)');
ylabel('Amplitude (V)');
title('Espectro de frequências que compõe a onda quadrada');

#--------------Figura contrapondo a onda fundamental e suas harmonicas com a onda quadrada gerada 
figure(2)
plot(1e3*t,y_fund,'b')
axis([0 3 -1.2*A_fund 1.2*A_fund])
xlabel('Tempo (ms)');
ylabel('Amplitude (V)');
title('Onda quadrada e senóides que a compõe');
hold on
plot(1e3*t,y1,'y')
hold on
plot(1e3*t,y2,'m')
hold on
plot(1e3*t,y3,'c')
hold on
plot(1e3*t,y4,'g')
hold on
plot(1e3*t,y5,'k')
hold on 
plot(1e3*t,y,'r:--')
hold off






