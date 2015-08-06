Fs=200; % Sampling frequency 
t=-1:1/Fs:1;
y=zeros(size(t));

% Rectangular pulse 
for n=1:length(t)
if t(n)>-0.5 && t(n)<0.5
 y(n)=1;
end
end
plot(t,y)
axis([-1 1 -1 2])
grid on

% Discrete Fourier  Transform 
 L=length(y);
 N=ceil(log2(L));
 fy=fft(y,2^N)/(L/2);
 f=(Fs/2^N)*(0:2^(N-1)-1);
 figure, plot(f,abs(fy(1:2^(N-1))));
 
 
 
 