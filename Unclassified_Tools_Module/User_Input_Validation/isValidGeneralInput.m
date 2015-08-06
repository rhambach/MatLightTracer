function [ valid,reason ] = isValidGeneralInput( varargin )
    % validInput: Validates user input to the toolbox depending on the type
    % Inputs:
    %  input_args: array of [Value1, Type1,Value2, Type2,...]
    %    where Type is string indicating the type of the value being validated
    % Outputs:
    %  valid : array of 0s or 1s showing validity of inputs
    %  reason: cell array of reasons for validity and invalidity of the
    %  input 
    if nargin < 1
        valid = 1;
        reason = 'Validation code not defined yet';
        return;
    end
    for kk=2:2:nargin
        inputValue = varargin{kk-1};
        inputType = varargin{kk};
        switch inputType
            case 'TiltDecenterOrder'
                % length should be 12
                if length(inputValue) ~= 12
                    valid(kk/2) = 0;
                    reason{kk/2} = 'Length of TiltDecenterOrder should be 12.';
                    continue;
                end
                % only strings made of Dx,Dy,Dz,Tx,Ty & Tz are valid
                % to be written in the future!!
                orderStr = upper(inputValue);         
                dx = findstr(orderStr,'DX');
                dy = findstr(orderStr,'DY');
                dz = findstr(orderStr,'DZ');
                tx = findstr(orderStr,'TX');
                ty = findstr(orderStr,'TY');
                tz = findstr(orderStr,'TZ');
                if (isempty(dx)||isempty(dy)||isempty(tx)||isempty(ty)||isempty(tz))
                    valid(kk/2) = 0;
                    reason{kk/2} = 'All tilt and decenter parameters should be in the order.';
                    continue;                    
                end                
                valid(kk/2) = 1;
                reason{kk/2} = 'Passed All Validity Test.';
                                       
            case 'Number' 
                % To be continued in the future ass needed!!
                
        end
    end 
end
