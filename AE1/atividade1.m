#------DESCRIÇÃO ATIVIDADE 1 - MARÇO 2020
#ANÁLISE DE SINAIS NO DOMÍNIO DO TEMPO E DA FREQUÊNCIA. 
#OBTENÇÃO DA POTÊNCIA DO SINAL E A DENSIDADE ESPECTRAL DO SINAL

#------AUTHOR
#SAROM TORRES

clc;clear all;close all;

%FREQUENCIAS
f = 1e3; %frequencia do sinal
f1 = 3e3;
f2 = 5e3;
N = 30; %numero de amostras
fs = f*N; %frequencia de amostragem

%TEMPOS
T = 1/f; %período do sinal
Ts = 1/fs; % período de amostragem
qt_periodo = 250; %quantidade de periodos
t_final = qt_periodo*T;
t = [0:Ts:t_final];

passo_freq = 1/t_final;
freq = [-fs/2:passo_freq:fs/2];  

%COSSENOS
A0 = 6; 
A1 = 2;
A2 = 4;

y1 = A0*sin(2*pi*f*t);
y2 = A1*sin(2*pi*f1*t);
y3 = A2*sin(2*pi*f2*t);

st = y1+y2+y3;
 
%TRANSFORMADAS
Y1 = fft(y1)/length(y1);
Y2 = fft(y2)/length(y2);
Y3 = fft(y3)/length(y3);
Sf = fft(st)/length(st);

%POTENCIA
pot = (norm(st)^2)/length(st)

%DENSIDADE ESPECTRAL DE ENERGIA
[dep,win] = pwelch(st,[],[],[],fs);


%PLOT SINAIS NO DOMÍNIO DO TEMPO
figure(1)

subplot(411);
plot(1e3*t,y1,'m');
axis([0 3 (-A0-1) (A0+1)]);
xlabel('Tempo (ms)');
ylabel('Amplitude (V)');
title('(a)');

subplot(412);
plot(1e3*t,y2,'g');
axis([0 3 -A0 A0]);
xlabel('Tempo (ms)');
ylabel('Amplitude (V)')
title('(b)');

subplot(413);
plot(1e3*t,y3,'b');
axis([0 3 -A0 A0]);
xlabel('Tempo (ms)');
ylabel('Amplitude (V)');
title('(c)');

subplot(414);
plot(1e3*t,st,'r');
axis([0 3 -15 15]);
xlabel('Tempo (ms)');
ylabel('Amplitude (V)');
title('(d)');


%PLOT SINAIS NO DOMÍNIOO DA FREQUÊNCIA
figure(2)
subplot(411);
plot(freq/1e3,abs(fftshift(Y1)),'m');
axis([(-f2/1e3-2) (f2/1e3+2) 0 4])
xlabel('Frequência (kHz)');
ylabel('Amplitude (V)');
title('(a)');

subplot(412);
plot(freq/1e3,abs(fftshift(Y2)),'g');
axis([(-f2/1e3-2) (f2/1e3+2) 0 4 ])
xlabel('Frequência (kHz)');
ylabel('Amplitude (V)');
title('(b)');

subplot(413);
plot(freq/1e3,abs(fftshift(Y3)),'b');
axis([(-f2/1e3-2) (f2/1e3+2) 0 4])
xlabel('Frequência (kHz)');
ylabel('Amplitude (V)');
title('(c)');

subplot(414);
plot(freq/1e3,abs(fftshift(Sf)),'r');
axis([(-f2/1e3-2) (f2/1e3+2) 0 4])
xlabel('Frequência (kHz)');
ylabel('Amplitude (V)');
title('(d)');

%PLOT DA DENSIDADE ESPECTRAL
figure(3)
plot(win/1000,5*log10(dep))
xlim([0 20]);
xlabel('Frequência (kHz)');
ylabel('DEP (dB/Hz)');
title('Densidade Espectral de Potência de s(t)');




