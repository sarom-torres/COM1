clear all;
close all;
clc

f_info = 1e3;
fc = 20e3;
N = 100;
fs = N*fc;
ts = 1/fs;
Ai = 2;
Ao = 2.5;
Ac = 1;
indice_mod = Ai/Ao
t_final = 0.5;
t = [0:ts:t_final];
info =Ao+(Ai*cos(2*pi*f_info*t));
c = Ac*cos(2*pi*fc*t);
sinal_modulado = info.*c;
f = [-fs/2:2:fs/2];
INFO = fft(info);
INFO = fftshift(INFO);
C = fft(c);
C = fftshift(C);
S = fft(sinal_modulado);
S = fftshift(S);

figure(1)
subplot(311)
plot(t,info)
xlim([0 2/f_info])
subplot(312)
plot(t,c)
xlim([0 2/f_info])
subplot(313)
plot(t,sinal_modulado)
xlim([0 2/f_info])

figure(2)
subplot(311)
plot(f,abs(INFO)/length(c))
xlim([-25e3 25e3])
subplot(312)
plot(f,abs(C)/length(c))
xlim([-25e3 25e3])
subplot(313)
plot(f,abs(S)/length(c))
xlim([-25e3 25e3])

figure(3)
plot(t,info)
xlim([0 2/f_info])
hold on
plot(t,sinal_modulado)
xlim([0 2/f_info])
T = length(info);
P_tx = (1/T)*sum(sinal_modulado.^2)
P_c_tx = 0.5*(Ao*Ac)^2
P_bli = (1/8)*(indice_mod^2)*(Ao*Ac)^2
P_bls = (1/8)*(indice_mod^2)*(Ao*Ac)^2
Percentual_P_portadora = (P_c_tx/P_tx)*100
Percentual_P_nas_BLs = ((P_bli+P_bls)/P_tx)*100