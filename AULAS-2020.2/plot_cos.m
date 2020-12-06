clear all; close all; clc;

fm = 1e3;
fc = 10e3;
N = 100; # número de amostras
fs = N*fm; #frequencia de amostragem

#eixo do tempo
ts = 1/fs;
t_final = 1;
t = [0:ts:t_final];


#eixo da frequencia
passo_f = 1; #para o vetor de f ficar do mesmo tamanho que Y e y é necessário que o passo do vetor seja o inverso do tempo final que é quem delimita o tamamnho do vetor de tempo
f = [-fs/2:passo_f:fs/2];

#sinal no tempo
A = 10;
y = A*cos(2*pi*fm*t);
c = exp(j*2*pi*fc*t);
s = y.*c;

#sinal na frequencia
Y = fft(y);
Y = fftshift(Y);

C = fft(c);
C = fftshift(C);

S = fft(s);
S = fftshift(S);

#plots
figure(1)
subplot(211)
plot(t,y)
axis([0 2*(1/fm) -1.2*A 1.2*A])
subplot(212)
plot(f,abs(Y)/length(y))

T = length(y);
Ex = sum(y.^2)/N; # Normalizando com o número de amostrar para não ter variação na energia conforme muda o N. Isso deixará o cálculo independente do numero de amostras e apenas depoendento do sinal
Px = (1/T)*sum(y.^2)
Pc = (1/T)*sum(c.^2)
Ps = (1/T)*sum(s.^2)

figure(2)
subplot(311)
plot(t,real(c))
xlim([0 2*(1/fc)])
hold on
plot(t,imag(c))
hold off

subplot(312)
plot(t,real(s))
xlim([0 50*(1/fc)])
subplot(313)
plot(t,imag(s))
xlim([0 50*(1/fc)])

figure(3)
subplot(311)
plot(f,abs(Y)/length(y))
xlim([-15e3 15e3])
subplot(312)
plot(f,abs(C)/length(c))
xlim([-15e3 15e3])
subplot(313)
plot(f,abs(S)/length(s))
xlim([-15e3 15e3])
