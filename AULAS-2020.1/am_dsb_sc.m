clc
clear all
close all

fm = 1e3; %frequencia do m
fc = 10e3; %frequencia de c
N = 200; 
fs = N*fm; %frequencia de amostragem
t = [0:1/fs:1]; 
num_periodo = 250; %numero de periodos
t_final = num_periodo*(1/fm);
Ts = 1/fs; %tempo de amostragem (espaço entre as amostras)
t = [0:Ts:t_final]; 
passo_f = 1/t_final; %para vincular o sinal de entrada com o gráfico da frequencia
freq = [-fs/2:passo_f:fs/2];

Am = 1;
Ac = 1;
Ao = 2; % O Ao é o nivel de tensão dc que não permite que o sinal cruze o zero para não ocorrer inversão de fase
mt = Am*cos(2*pi*fm*t);
ct = Ac*cos(2*pi*fc*t);

st_AM_DSB_SC = mt.*ct;
st_AM_DSB = (mt + Ao).*ct;

figure(1)
subplot(411)
plot(t,mt+Ao)
xlim([0 10/fm]) %pega 2 periode de fm
subplot(412)
plot(t,ct)
xlim([0 10/fm])
subplot(413)
plot(t, st_AM_DSB_SC)
xlim([0 10/fm])
subplot(414)
plot(t,st_AM_DSB)
xlim([0 10/fm])

Mf = fft(mt)/length(mt);
Cf = fft(ct)/length(ct);
Sf_AM_DSB_SC = fft(st_AM_DSB_SC)/length(st_AM_DSB_SC);
Sf_AM_DSB = fft(st_AM_DSB)/length(st_AM_DSB);


figure(2)
subplot(411)
plot(freq,abs(fftshift(Mf)))
xlim([-2*fm 2*fm])
subplot(412)
plot(freq,abs(fftshift(Cf)))
xlim([-2*fc 2*fc])
subplot(413)
plot(freq, abs(fftshift(Sf_AM_DSB_SC)))
xlim([-2*fc 2*fc])
subplot(414)
plot(freq,abs(fftshift(Sf_AM_DSB)))
xlim([-2*fc 2*fc])



