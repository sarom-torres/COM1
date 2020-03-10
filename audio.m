clear all;
load handel;

%sound(y)
y = transpose(y);
t_audio = length(y)/Fs;
t = [0:1/Fs:t_audio-1/Fs];
%plot(t,y)

Y=fft(y);
Y = fftshift(Y);

freq = [-Fs/2:(1/t_audio):Fs/2-(1/t_audio)];
subplot(211)
plot(t,y)
subplot(212)
plot(freq,abs(Y))