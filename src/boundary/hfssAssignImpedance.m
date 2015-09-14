% ----------------------------------------------------------------------------
% This file is part of HFSS-MATLAB-API.
%
% HFSS-MATLAB-API is free software; you can redistribute it and/or modify it 
% under the terms of the GNU General Public License as published by the Free 
% Software Foundation; either version 2 of the License, or (at your option) 
% any later version.
%
% HFSS-MATLAB-API is distributed in the hope that it will be useful, but 
% WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY 
% or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License 
% for more details.
%
% You should have received a copy of the GNU General Public License along with
% Foobar; if not, write to the Free Software Foundation, Inc., 59 Temple 
% Place, Suite 330, Boston, MA  02111-1307  USA
%
% Copyright 2004, Vijay Ramasami (rvc@ku.edu)
% ----------------------------------------------------------------------------

function hfssAssignImpedance(fid, ImpedanceName, SheetObject, Resistance, Reactance, InfGroundPlane)
    % Creates the VB Script necessary to assign a Impedance boundary to a (sheet-like)
    % object or face.
    %
    % Parameters :
    % fid:              file identifier of the HFSS script file.
    % ImpedanceName:    name of the Impedance boundary (will appear under 'Boundaries').
    % SheetObject:      name of the (sheet-like) object or face to which the wave port is
    %                  to be assigned.
    % Resistance:       Resistance value in ohms
    % Reactance:        Reactance value in ohms
    % InfGroundPlane:  (optional)If infinite ground plane then true, else false. Default is false.
    %
    % Example :
    % * Impedance boundary to Face 34 of a box. Resistance=100 and Reactance=0
    % and No Infinite GND Plane.
    % @code
    % fid = fopen('myantenna.vbs', 'wt');
    % ... 
    % hfssAssignImpedance(fid, 'Impedance1', '34',100)
    % @endcode
    % * Impedance boundary to Face 34 of a box. Resistance=100 and
    % Reactance=50. No Infinite Ground Plane
    % @code
    % hfssAssignImpedance(fid, 'Impedance1', '34',100,50)
    % @endcode
    %
    % @author Rounak Singh Narde (rn5949@rit.edu)
    %
    % ----------------------------------------------------------------------------

    if (nargin < 5)
        Reactance=0;
        InfGroundPlane = 'false';
    elseif (nargin == 5)
        InfGroundPlane = 'false';
    end
    
    % Preamble.
    fprintf(fid, '\n');
    fprintf(fid, 'Set oModule = oDesign.GetModule("BoundarySetup") \n');
    fprintf(fid, '\n');
    fprintf(fid, 'oModule.AssignImpedance _\n');
    fprintf(fid, 'Array( _\n');
    fprintf(fid, '"NAME:%s", _\n', ImpedanceName);
    fprintf(fid, '"Faces:=", Array(%s), _\n', SheetObject);
    fprintf(fid, '"Resistance:=", "%f", _\n', Resistance);
    fprintf(fid, '"Reactance:=", "%f", _\n', Reactance);
    fprintf(fid, '"InfGroundPlane:=", %s)\n', InfGroundPlane);

end
                            
