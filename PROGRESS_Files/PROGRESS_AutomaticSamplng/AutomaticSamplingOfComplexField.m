N = 10000;
x = linspace(-1,1,N);
%% Amplitude
w = 0.2;
ampE = exp(-(x.^2)/w^2); % Gaussian profile
figure; plot(x,ampE)

%% Phase 
r = 200;
wav = 10^-6;
phaseE = -(2*pi/wav)*sqrt(r^2-(x).^2);
phaseE2 = angle(exp(1i*phaseE));
phaseE2Unwrap = unwrap(phaseE2);

% Get the linear and quadratic phase
p = polyfit(x,phaseE2,2);
phaseE2RemoveQuadratic = phaseE2 - (p(1)*x.^2 + p(2)*x + p(3));
phaseE2RemoveQuadraticUnwrap = unwrap(phaseE2RemoveQuadratic);

figure; plot(x,phaseE)
figure; plot(x,phaseE2)
figure; plot(x,phaseE2Unwrap)
figure; plot(x,phaseE2RemoveQuadratic)
figure; plot(x,phaseE2RemoveQuadraticUnwrap)
