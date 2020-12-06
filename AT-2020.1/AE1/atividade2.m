#------DESCRIÇÃO ATIVIDADE 12 - MARÇO 2020
#ANÁLISE DE SINAIS NO DOMÍNIO DO TEMPO E DA FREQUÊNCIA ANTES E APÓS FILTRAGEM.
#CONSTRUÇÃO DE FILTROS DE DIFERENTES CATEGORIAS

#------AUTHOR
#SAROM TORRES

clc; clear all; close all;

%FREQUENCIAS
f = 1e3; %frequencia do sinal
f1 = 3e3;
f2 = 5e3;
N = 10; %numero de amostras
fs = f2*N; %frequencia de amostragem

%TEMPOS
T = 1/f; %período do sinal
Ts = 1/fs; % período de amostragem
qt_periodo = 250; %quantidade de periodos
t_final = qt_periodo*T;
t = [0:Ts:t_final];

passo_freq = 1/t_final;
freq = [-fs/2:passo_freq:fs/2];  

%COSSENOS
A0 = 5; 
A1 = 5/3;
A2 = 1;

y1 = A0*sin(2*pi*f*t);
y2 = A1*sin(2*pi*f1*t);
y3 = A2*sin(2*pi*f2*t);

st = y1+y2+y3;
 
%TRANSFORMADAS
Y1 = fft(y1)/length(y1);
Y2 = fft(y2)/length(y2);
Y3 = fft(y3)/length(y3);
Sf = fft(st)/length(st);

%FILTROS
wn1 = (2e3)*2/fs;
wn2 = (4e3)*2/fs;
filtro_PB = fir1(50,wn1,'low');
filtro_PA = fir1(50,wn2,'high');
filtro_PF = fir1(50,[wn1 wn2]);
%filtro_PF = fir1(50,wn1,'low') - fir1(50,wn2,'high');

%SINAIS FILTRADOS
st_filt_PB = filter(filtro_PB,1,st);
st_filt_PA = filter(filtro_PA,1,st);
st_filt_PF = filter(filtro_PF,1,st);

%TRANSFORMADAS DOS SINAIS FILTRADOS
Sf_filt_PB = fft(st_filt_PB)/length(st_filt_PB);
Sf_filt_PA = fft(st_filt_PA)/length(st_filt_PA);
Sf_filt_PF = fft(st_filt_PF)/length(st_filt_PF);

##%PLOT SENOS NO TEMPO
figure(1)
subplot(421);
plot(1e3*t,y1,'m');
axis([0 3 (-A0-1) (A0+1)]);
xlabel('Tempo (ms)');
ylabel('Amplitude (V)');
title('(a)');

subplot(423);
plot(1e3*t,y2,'g');
axis([0 3 -A0 A0]);
xlabel('Tempo (ms)');
ylabel('Amplitude (V)')
title('(c)');

subplot(425);
plot(1e3*t,y3,'b');
axis([0 3 -A0 A0]);
xlabel('Tempo (ms)');
ylabel('Amplitude (V)');
title('(e)');

subplot(427);
plot(1e3*t,st,'r');
axis([0 3 -15 15]);
xlabel('Tempo (ms)');
ylabel('Amplitude (V)');
title('(g)');

%PLOT SENOS NA FREQUÊNCIA
subplot(422);
plot(freq/1e3,abs(fftshift(Y1)),'m');
axis([(-f2/1e3-2) (f2/1e3+2) 0 4])
xlabel('Frequência (kHz)');
ylabel('Amplitude (V)');
title('(b)');

subplot(424);
plot(freq/1e3,abs(fftshift(Y2)),'g');
axis([(-f2/1e3-2) (f2/1e3+2) 0 4 ])
xlabel('Frequência (kHz)');
ylabel('Amplitude (V)');
title('(d)');

subplot(426);
plot(freq/1e3,abs(fftshift(Y3)),'b');
axis([(-f2/1e3-2) (f2/1e3+2) 0 4])
xlabel('Frequência (kHz)');
ylabel('Amplitude (V)');
title('(f)');

subplot(428);
plot(freq/1e3,abs(fftshift(Sf)),'r');
axis([(-f2/1e3-2) (f2/1e3+2) 0 4])
xlabel('Frequência (kHz)');
ylabel('Amplitude (V)');
title('(h)');


%PLOT FILTROS
figure(2)
freqz(filtro_PB)
figure(3)
freqz(filtro_PA)
figure(4)
freqz(filtro_PF)

##%PLOT SINAIS FILTRADOS
figure(5)
subplot(321);
plot(1e3*t,st_filt_PB,'m');
axis([1 4 (-A0-1) (A0+1)]);
xlabel('Tempo (ms)');
ylabel('Amplitude (V)');
title('Sinal s(t) após filtro passa-baixa de 2kHz');

subplot(323);
plot(1e3*t,st_filt_PA,'b');
axis([1 4 (-A1-1) (A1+1)]);
xlabel('Tempo (ms)');
ylabel('Amplitude (V)');
title('Sinal s(t) após filtro passa-alta de 4kHz');

subplot(325);
plot(1e3*t,st_filt_PF,'r');
axis([1 4 (-A0-1) (A0+1)]);
xlabel('Tempo (ms)');
ylabel('Amplitude (V)');
title('Sinal s(t) após filtro passa-faixa de 2kHz-4kHz');

%PLOT TRANSFORMADAS DOS SINAIS FILTRADOS

subplot(322);
plot(freq/1e3,abs(fftshift(Sf_filt_PB)),'m');
axis([(-f2/1e3-2) (f2/1e3+2) 0 4 ])
xlabel('Frequência (kHz)');
ylabel('Amplitude (V)');
title('Espectro de s(t) após filtro passa-baixa de 2kHz');

subplot(324);
plot(freq/1e3,abs(fftshift(Sf_filt_PA)),'b');
axis([(-f2/1e3-2) (f2/1e3+2) 0 2 ])
xlabel('Frequência (kHz)');
ylabel('Amplitude (V)');
title('Espectro de s(t) após filtro passa-alta de 4kHz');

subplot(326);
plot(freq/1e3,abs(fftshift(Sf_filt_PF)),'r');
axis([(-f2/1e3-2) (f2/1e3+2) 0 4 ])
xlabel('Frequência (kHz)');
ylabel('Amplitude (V)');
title('Espectro de s(t) após filtro passa-faixa de 2kHz-4kHz');

##% !!!! NÃO ESTÁ CORRETO
##
##subplot(313);
##plot(freq,abs(fftshift(Sf_filt_PF)));
##axis([(-f2-2e3) (f2+2e3) -4 4])
