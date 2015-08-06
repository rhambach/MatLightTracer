function [ newMeritFunction ] = MeritFunction( meritFunctionName )
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
    
    if nargin == 0
        meritFunctionName = 'DefaultMeritFunction';
    end
    newMeritFunction.Name = meritFunctionName;
    newMeritFunction.Target = 0;
    newMeritFunction.Weight = 0;
    
    
    [fieldNames,fieldFormat,defaultUniqueParamStruct] = ...
        getMeritFunctionUniqueParameters(meritFunctionName);
    newMeritFunction.UniqueParameters = defaultUniqueParamStruct;
    
    newMeritFunction.OptimizableObject = getOptimizableObject(meritFunctionName); % object whose parameter is being optimized
    
    newMeritFunction.ClassName = 'MeritFunction';
end