N=2^13;
lambda=525e-6; % Wavelength defined in mm
d_x0=2/N; % I go from -1 mm to 1 mm so d_x0 is the step between each points..
D=60;

for j=1:N
x0(j)=-1+(j-1)*d_x0;
if (x0(j)>=-3.5e-3&&x0(j)<=3.5e-3) % Slit location, total slit width is 50 microns
slit(j)=exp(j*2*pi/lambda*x0(j)^2/(2*D));
else slit(j)=0;
end;
end;

diffr=fft(slit);
diffr1=fftshift(diffr);
%plot(x0,diffr1)
%%%
figure;
colormap 'gray'
imagesc(abs(diffr1));

% Read more: http://www.physicsforums.com
