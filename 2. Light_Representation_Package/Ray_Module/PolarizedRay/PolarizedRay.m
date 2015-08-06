function newPolarizedRay = PolarizedRay(scalarRay,jonesVector) % Constructor
    if nargin == 0
        % Empty constructor
        scalarRay = ScalarRay();
        newPolarizedRay.Position = scalarRay.Position;
        newPolarizedRay.Direction = scalarRay.Direction;
        newPolarizedRay.Wavelength = scalarRay.Wavelength;
        newPolarizedRay.Vignated = scalarRay.Vignated;
        
        jonesVector = NaN*[0;0];
        polarizationVector = NaN*[0;0;0];
        
        newPolarizedRay.JonesVector = jonesVector;
        newPolarizedRay.PolarizationVector = polarizationVector;
        newPolarizedRay.ClassName = 'PolarizedRay';
        return;
    elseif nargin == 1
        jonesVector = NaN*[0;0];
    else
    end
    
    % If the inputs are arrays the newRay becomes object array
    % That is when dir, pos and polVector = 3 X N matrix
    % jonesVect = 2 X 2 X N matrix
    
    % Determine the size of each inputs
    nScalarRay = size(scalarRay,2);
    nJV = size(jonesVector,2);
    % The number of array to be initialized is maximum of all inputs
    nMax = max([nScalarRay,nJV]);
    
    % Fill the smaller inputs to have nMax size by repeating their
    % last element
    if nScalarRay < nMax
        scalarRay = cat(2,scalarRay,repmat(scalarRay(end),[1,nMax-nScalarRay]));
    end
    if nJV < nMax
        jonesVector = cat(2,jonesVector,repmat(jonesVector(:,end),[1,nMax-nJV]));
    end
    
    % Preallocate object array
    newPolarizedRay(nMax) = PolarizedRay;
    for kk = 1:nMax
        newPolarizedRay(kk).Position = scalarRay(kk).Position;
        newPolarizedRay(kk).Direction = scalarRay(kk).Direction;
        newPolarizedRay(kk).Wavelength = scalarRay(kk).Wavelength;
        newPolarizedRay(kk).Vignated = scalarRay(kk).Vignated;
        
        newPolarizedRay(kk).JonesVector = jonesVector(:,kk);
        newPolarizedRay(kk).PolarizationVector = NaN*[0;0;0];
        newPolarizedRay(kk).ClassName = 'PolarizedRay';
    end
end

