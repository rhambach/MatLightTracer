function [ output_args ] = computeCoatingPMatrix( input_args )
%COMPUTECOATINGPMATRIX computes the 3 x 3 polarization matrix for given
%coating and incidence angles and input and output 

% compute the new P matrix
            coatingPMatrix = convertJonesMatrixToPolarizationMatrix(coatingJonesMatrix,Kqm1,Kq); 
            
end

