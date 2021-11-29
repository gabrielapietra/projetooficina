clear
clc

[y,fs] = audioread('audio1.mp3');
%número de amostras por segundo fs = 44100
y = y(:,1)+y(:,2);

t = 0:1/fs:(numel(y)-1)/fs;
%figure(1)
plot(t,y);
title('Som no domínio do tempo')

%% TRANFORMADA DE FOURIER
transf = fft(y);
transf = transf(1:floor(length(transf)/2));
n = numel(y);
freq = (0:n-1).*fs/n;
freq = freq(1:floor(length(freq)/2));
%figure(2)
plot(freq, abs(transf));
axis([0 15000 0 2000])
title('Domínio da frequência')

%% OUVIR SOM 
%sound(y, fs)

%% FILTRAR
d = designfilt ( 'lowpassiir' , ...         % Tipo de resposta 
       'PassbandFrequency' , 400, ...      % Restrições de frequência 
       'StopbandFrequency' , 1000, ... 
       'PassbandRipple' , 1, ...           % Restrições de magnitude 
       'StopbandAttenuation' , 60, ... 
       'DesignMethod' , 'butter' , ...       % Método de design 
       'MatchExactly' , 'passband' , ...    % Opções de método de design 
       'SampleRate' , 2000)                % Taxa de amostragem
%fvtool(d);
filtrado = filter(d,y);
figure(3)
plot(t, filtrado)
title('Som filtrado')
