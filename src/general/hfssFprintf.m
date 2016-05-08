%
%
% New fprintf to automatically get cell values and convert it into the
% string or double as necessary.
% Maximum two variable arguments\
% Don't use %m for entering values other than HFSS use. 
% Use general format specifier instead.
% like to write two strings at same time don't use %m.
% This program is specifically written to fprintf variables and values with
% unit for HFSS-script.
%
% %m means one of the following
%   no format specifier -- prints string as it is.
%   %f -- only float (1 argument)
%   %s -- only string (1 argument)
%   %s -- with 2 arguments
%   %f%s -- with 2 arguments (value and unit)


function nbytes=hfssFprintf(fileID, formatSpec, varargin)
    % This function is a modified form of fprintf to work with special requirement of HFSS scripting.
    % The special requirement is to work with variables in HFSS using
    % scripts, so it is required to provide names of variables as
    % values of quantity such as length, frequency, etc. The requirement
    % comes when a user wants to setup a Optimetric operation. 
    % 
    % Moreover, it is an internal function of the hfss-api, which means 
    % that it may not be used by direct user, but hfss-api developer.
    % It is more of a inner layer function.
    %
    % As of now it can take two variable arguments. Genrally used types of
    % variables are explained below:
    % 
    % Parameters :
    % fid:      file identifier of the HFSS script file.
    % Name:     name of the PEC boundary. This will appear under "Boundaries" 
    %           in HFSS
    % Type:     type of list -- object(Type=0)  or face(Type=1).
    % ObjectList:  a cell array of objects or faceID to which the PEC boundary condition will
    %           be applied.
    % infGND:   (boolean, optional) specify as true to make the PEC represent an infinite
    %           ground plane (default is false).
    % 
    % Example :
    % @code
    % fid = fopen('myantenna.vbs', 'wt');
    % ... 
    % % Applying Object boundary to object 'AntennaGND'
    % hfssAssignPE(fid, 'GNDplane', 1, {'AntennaGND'}, true);
    % ...
    % % Applying PE boundary to faceID 7,8,9,11
    % hfssAssignPE(fid,'PE1',1,{'7','8','9','11'});
    % @endcode
  
    switch nargin
        % Only two arguments
        case 2
            nbytes=fprintf(fileID,formatSpec);
            
        % Three arguments
        case 3
            % Check if it has a %m in format specifier (User-defined format specifier)
            if strfind(formatSpec,'%m')>0
                %Check if the first argument is string
                if ischar(varargin{1})
                    formatSpec=strrep(formatSpec, '%m', '%s');
                %Check if the first argument is float
                elseif isfloat(varargin{1})
                    formatSpec=strrep(formatSpec, '%m', '%f');
                end
            end
            % It is written outside the if so as it output general fprintf
            % operations, which don't have %m
            nbytes = fprintf(fileID,formatSpec,varargin{1});
            
        %Four arguments
        case 4
            % Check if it has a '%m' in format specifier (User-defined format specifier)
            if strfind(formatSpec,'%m')>0
                % Check if the first argument is string (For HFSS-Variables)
                if ischar(varargin{1})
                    formatSpec=strrep(formatSpec, '%m', '%s');
                    nbytes = fprintf(fileID,formatSpec,varargin{1});
                % Check if the first argument is float (For dimensions with units)
                elseif isfloat(varargin{1}) && ischar(varargin{2})
                    formatSpec=strrep(formatSpec, '%m', '%f%s');
                    nbytes = fprintf(fileID,formatSpec,varargin{1},varargin{2});
                end
            else
                % It is written outside the if so as it output general fprintf
                % operations, which don't have %m
                nbytes = fprintf(fileID,formatSpec,varargin{1},varargin{2});
            end

            
        otherwise
    end
    
end