clear
clc

[y,fs]=audioread('Derezzed.m4a');   %y é o sinal no domínio do tempo
fs                                  %fs é a freq de amostragem do áudio (qtd de amostras por segundo)
y = y(:,1) + y(:,2);                %y(:,1) é a primeira coluna de y e y(:,2) é a segunda coluna de y

%quando o matlab leu o áudio, ele colocou as informações em uma matriz de
%duas colunas, daí ali em cima foi transformado em um vetor de apenas uma
%coluna

t = 0:1/fs:(numel(y)-1)/fs;
figure(1)
plot(t,y);
title('Som no Domínio do Tempo')


%transformada de fourrier de y:
transf = fft(y);
transf = transf(1:floor(length(transf)/2));
n = numel(y);
freq = (0:n-1).*fs/n;
freq = freq(1:floor(length(freq)/2));
figure(2);
title('Som no Domínio da Frequência')
xlabel("Frequência(Hz)");
ylabel("dB");
plot(freq,abs(transf));
axis([0 23000 0 10000])


% FILTROS

banda1 = designfilt('bandpassiir','FilterOrder',10,'PassbandFrequency1',100,'PassbandFrequency2',2000,'PassbandRipple',1,'SampleRate',44100);
filtrado1 = filter(banda1,y);
%figure(3)
%plot(t,filtrado1)

banda2 = designfilt('bandpassiir','FilterOrder',10,'PassbandFrequency1',2000,'PassbandFrequency2',3000,'PassbandRipple',1,'SampleRate',44100);
filtrado2 = filter(banda2,y);

banda3 = designfilt('bandpassiir','FilterOrder',10,'PassbandFrequency1',3000,'PassbandFrequency2',4000,'PassbandRipple',1,'SampleRate',44100);
filtrado3 = filter(banda3,y);

banda4 = designfilt('bandpassiir','FilterOrder',10,'PassbandFrequency1',4000,'PassbandFrequency2',5000,'PassbandRipple',1,'SampleRate',44100);
filtrado4 = filter(banda4,y);
%figure(3)
%plot(t,filtrado3)