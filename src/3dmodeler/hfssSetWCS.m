function hfssSetWCS(fid, Name)
	% Sets the working coordinate system. It can be the 'Global' CS or
	% another created by the user with the function hfssCreateRelativeCS.
	%
	% Parameters :
	% fid:		file identifier of the HFSS script file.
	% Name:		name of the coordinate system to set as the WCS.
	% 
	% Example :
	% @code
	% fid = fopen('myantenna.vbs', 'wt');
	% ...
	% hfssSetWCS(fid, 'Global')
	% @endcode
	% 
	% @author Daniel R. Prado, danysan@gmail.com / drprado@tsc.uniovi.es
	% @date 21 September 2012

	% arguments processor.
	if (nargin < 2)
		error('Insufficient number of arguments !');
	end;

	% Preamble.
	fprintf(fid, '\n');
	fprintf(fid, 'oEditor.SetWCS _\n');

	% WCS Parameters
	fprintf(fid, 'Array("NAME:SetWCS Parameter", _\n');
	fprintf(fid, '"Working Coordinate System:=", "%s")\n', Name);