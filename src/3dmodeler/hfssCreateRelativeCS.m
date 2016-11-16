function hfssCreateRelativeCS(fid, Name, Origin, Units)
	% Create a relative(offset ) coordinate system "origin" point relative to the
	% Global Coordinate System.
	%
	% Parameters :
	% fid:		file identifier of the HFSS script file.
	% Name:		Name of the relative coordinate system.
	% Origin:	point relative to the Global Coordinate System where the Relative Coordinate System will be created.
	% Units:	units of the points (specify using either 'in', 'mm', 'meter' or anything else defined in HFSS).
	% 
	% @note Use this function to facilitate drawing stuff. To return to use
	% another CS (i.e. the Global CS), you can use the function hfssSetWCS
	%
	% Example :
	% @code
	% fid = fopen('myantenna.vbs', 'wt');
	% ...
	% hfssInsertDesign(fid, 'Dipole_SingleElement');
	% @endcode
	%
	% @author Daniel R. Prado, danysan@gmail.com / drprado@tsc.uniovi.es
	% @date 20 September 2012

	% arguments processor.
	if (nargin < 4)
		error('Insufficient number of arguments !');
	end;
    
    if ~iscell(Origin)
        Origin=num2cell(Origin);
    end
    
	% Preamble.
	fprintf(fid, '\n');
	fprintf(fid, 'oEditor.CreateRelativeCS _\n');

	% CS Parameters
	fprintf(fid, 'Array("NAME:RelativeCSParameters", _\n');
	hfssFprintf(fid, '"OriginX:=", "%m", _\n', Origin{1}, Units);
	hfssFprintf(fid, '"OriginY:=", "%m", _\n', Origin{2}, Units);
	hfssFprintf(fid, '"OriginZ:=", "%m", _\n', Origin{3}, Units);
	fprintf(fid, '"XAxisXvec:=", "1%s", _\n', Units);
	fprintf(fid, '"XAxisYvec:=", "0%s", _\n', Units);
	fprintf(fid, '"XAxisZvec:=", "0%s", _\n', Units);
	fprintf(fid, '"YAxisXvec:=", "0%s", _\n', Units);
	fprintf(fid, '"YAxisYvec:=", "1%s", _\n', Units);
	fprintf(fid, '"YAxisZvec:=", "0%s"), _\n', Units);

	% CS Attributes
	fprintf(fid, 'Array("NAME:Attributes", _\n');
	fprintf(fid, '"Name:=", "%s")\n', Name);