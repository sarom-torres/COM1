#------DESCRIÇÃO ATIVIDADE 3 - MARÇO 2020
#ANÁLISE DE SINAIS RUIDO, AUTOCORRELAÇÃO E FILTRAGEM DO SINAL 

#------AUTHOR
#SAROM TORRES

clc; clear all; close all;

fs= 10e3;
ts = 1/fs;
t = [0:ts:1-ts]

%RUIDO
ruido = randn(size(t));
ruido = randn(1,fs);
%HISTOGRAMA RUIDO
figure(1)
hist(ruido,100);
title('Ruido')

%SINAL ALEATÓRIO MAIS RUIDO
info = randi([0 1],1,fs)*2-1;
info_format = rectpuls(info,100);

ruido2 = rand(1,length(info_format));
r = info_format + ruido2;

%PLOT SINAL + RUIDO
figure(2)
plot(r)
title('Sinal com ruido')
xlim([0 1500]);

%AUTOCORRELAÇÃO
Rx = xcorr(info_format);
Gx = fft(Rx);
Gx = fftshift(Gx);
figure(4)
plot(abs(Gx))
title('Autocorrelação do ruido')

%FILTRO
filtro = fir1(50,(1000*2)/fs);
figure(5)
freqz(filtro)

ruido_filt = filter(filtro,1,ruido);
Rf = fft(ruido_filt)/length(ruido_filt);

figure(6)
subplot(211)
plot(ruido_filt)
subplot(212)
plot(abs(fftshift(Rf)))

figure(7)
hist(ruido_filt)
