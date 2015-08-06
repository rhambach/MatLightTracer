%% Test Vectorized Ray Initialization
vectRay = Ray(magic(3));
tic
for kk=1:1000
vectRay1 = Ray;
end
toc % Elapsed Time = 1.5 sec
tic
vectRay2 = Ray(ones(3,1000));
toc % Elapsed Time = 0.018 sec Great Improvemnt
%% End of Test

%%