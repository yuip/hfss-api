% ----------------------------------------------------------------------------
% function hfssSetDesignSettings(fid, settings, values)
% 
% Description :
% -------------
% Create the VB Script necessary to modifty some individual design settings.
%
% Parameters :
% ------------
% fid      - File identifier of the HFSS script file.
% settings - Cell array of settings to be modified.
% values   - Cell array with the value of the settings.
%
% List of possible parameters and values (defaults with asterisk):
% ----------------------------------------------------------------
%   Use Advanced DC Extrapolation -> true|false*
%   Use Power S                   -> true|false*
%   Export After Simulation       -> true|false*
%   Allow Material Override       -> true|false*
%   Calculate Lossy Dielectrics   -> true|false*
%   Perform Minimal validation    -> true|false*
%   EnabledObjects                -> [not used]
%   Port Validation Settings      -> Standard*|Extended [see note]
%   Save Adaptive support files   -> true|false*
%   EntityCheckLevel              -> None|WarningOnly|Basic|Strict*
%   IgnoreUnclassifiedObjects     -> true|false*
%   SkipIntersectionChecks        -> true|false*
%
% Note:
% -----
% "Port Validation Settings" is only set if "Perform Minimal validation"
% is false. Otherwise, it is ignored. In this regard, "Perform Minimal
% validation" overrides "Port Validation Settings".
%
% Example :
% ---------
% fid = fopen('myantenna.vbs', 'wt');
% ... 
% hfssSetDesignSettings(fid, {'IgnoreUnclassifiedObjects'}, {'true'});
%
% ----------------------------------------------------------------------------

% ----------------------------------------------------------------------------
% CHANGELOG
%
% 09-Oct-2024: *Initial release.
% ----------------------------------------------------------------------------

% ----------------------------------------------------------------------------
% Written by Daniel R. Prado
% danysan@gmail.com / drprado.tsc@gmail.com
% 09 October 2024
% ----------------------------------------------------------------------------
function hfssSetDesignSettings(fid, settings, values)

% It only works if we write a vbs script with values for all options. We define
% the default values and change only for the options selected by the user.
setting_name = {'Use Advanced DC Extrapolation', ... % 1
                'Use Power S',                   ... % 2
                'Export After Simulation',       ... % 3
                'Allow Material Override',       ... % 4
                'Calculate Lossy Dielectrics',   ... % 5
                'Perform Minimal validation',    ... % 6
                'EnabledObjects',                ... % 7
                'Port Validation Settings',      ... % 8
                'Save Adaptive support files',   ... % 9
                'EntityCheckLevel',              ... % 10
                'IgnoreUnclassifiedObjects',     ... % 11
                'SkipIntersectionChecks',        ... % 12
               };

values_default = {'false',    ... % 1
                  'false',    ... % 2
                  'false',    ... % 3
                  'false',    ... % 4
                  'false',    ... % 5
                  'false',    ... % 6
                  'Array()',  ... % 7
                  'Standard', ... % 8
                  'false',    ... % 9
                  'Strict',   ... % 10
                  'false',    ... % 11
                  'false',    ... % 12
                 };

% Overwrite default values with user values.
for n = 1:numel(settings)
    idx = find(strcmp(setting_name, settings{n}));
    if ~isempty(idx)
        values_default{idx} = values{n};
    end
end

% Write all settings.
fprintf(fid, '\n');
fprintf(fid, 'oDesign.SetDesignSettings _\n');
fprintf(fid, 'Array("NAME:Design Settings Data", _\n');
for n = 1:7
    fprintf(fid, '"%s:=", %s, _\n', setting_name{n}, values_default{n});
end
% See note above.
if strcmp(values_default{6}, 'false')
    fprintf(fid, '"%s:=", "%s", _\n', setting_name{8}, values_default{8});
end
fprintf(fid, '"%s:=", %s _\n', setting_name{9}, values_default{9});
fprintf(fid, '), Array("NAME:Model Validation Settings", _\n');
fprintf(fid, '"%s:=", "%s", _\n', setting_name{10}, values_default{10});
fprintf(fid, '"%s:=", %s, _\n', setting_name{11}, values_default{11});
fprintf(fid, '"%s:=", %s)', setting_name{12}, values_default{12});