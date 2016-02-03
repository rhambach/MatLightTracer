function [ newMeritFunction ] = MeritFunction( meritFunctionName,...
        optimizationOperand,optimizableObject )
    % MeritFunction Struct:
    %
    %   Defines merit functions used in the toolbox. All merit functions 
    %   definitions are defined using external functions and this class makes
    %   calls to the external functions to work with the MeritFunction struct.
    %
    % Properties: -- and Methods: --
    %
    % Example Calls:
    %
    % newMeritFunction = MeritFunction('DefaultMeritFunction')
    %   Returns zemax merit function for return real y axis value.
    %
    
    if nargin < 3
        disp('Error: The function MeritFunction needs atleast 3 input argument. ');
        newMeritFunction = NaN;
        return;
    end
    
    newMeritFunction.Name = meritFunctionName;
    newMeritFunction.OptimizationOperand = optimizationOperand;
    newMeritFunction.OptimizableObject = optimizableObject;

    [fieldNames,fieldFormat,defaultUniqueParamStruct] = ...
        getMeritFunctionUniqueParameters(meritFunctionName);
    newMeritFunction.UniqueParameters = defaultUniqueParamStruct;

    newMeritFunction.ClassName = 'MeritFunction';
end