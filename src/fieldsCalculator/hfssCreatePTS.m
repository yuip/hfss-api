function hfssCreatePTS(Name, Start, Stop, Spacing, Units)
	% Creates a .pts file which defines the grid in which the field will be
	% exported by the fields calculator. Start coordinates must be smaller or
	% equal than Stop coordinates.
	%
	% Parameters :
	% Name:		name of the .pts file.
	% Start:	start coordinates of the cube in which the grid will be
	%            defined.
	% Stop:		end coordinates of the cube in which the grid will be defined.
	% Spacing:	spacing of the grid.
	% Units:	units in which the grid is defined.
	% 
	% @note If the start and end coordinates is the same for one or two dimensions,
	% a sheet or line can be defined.
	%
	% Example :
	% * For Volume
	% @code
	% hfssCreatePTS('MyGrid1', [0 0 0], [4 8 4], [0.1 0.2 0.1], 'mm');
	% @endcode
	% * For Surface
	% @code
	% hfssCreatePTS('MyGrid1', [0 0 0], [4 0 4], [0.1 0 0.1], 'mm');
	% @endcode
	% * For Line
	% @code
	% hfssCreatePTS('MyGrid1', [0 0 0], [0 0 4], [0 0 0.1], 'mm');
	% @endcode
	% 
	% @author Daniel R. Prado, danysan@gmail.com / drprado@tsc.uniovi.es
	% @date 03 October 2012
	
	% ----------------------------------------------------------------------------
	% CHANGELOG
	%
	% 03-Oct-2012: *Initial release.
	% 11-Aug-2014: *Faster way of creating grid.
	% ----------------------------------------------------------------------------

	% Arguments processor.
	if (nargin < 5)
		error('Insufficient # of arguments !');
	end

	% Error check
	if ~prod(double(Start <= Stop))
	    error(['Error in hfssCreatePTS: Start coord. must be smaller or ',...
	           'equal than Stop coord.']);
	end

	% Prevent malformed PTS due to 0 spacing
	Spacing(Spacing == 0) = 0.1;

	% Preamble
	fid = fopen([Name, '.pts'], 'w');
	fprintf(fid, 'Unit=%s\n', Units);

	% Faster way of computing the grid (needs plenty of testing).
	i = Start(1):Spacing(1):Stop(1);
	j = Start(2):Spacing(2):Stop(2);
	k = Start(3):Spacing(3):Stop(3);
	[I, J, K] = meshgrid(i, j, k);
	I = reshape(I, numel(i)*numel(j), 1);
	J = reshape(J, numel(i)*numel(j), 1);
	K = reshape(K, numel(i)*numel(j), 1);
	fprintf(fid, '%14.6f%14.6f%14.6f\n', [I'; J'; K']);

	% Generating the grid (by brute force)...
	%for i = Start(1):Spacing(1):Stop(1)
	%    for j = Start(2):Spacing(2):Stop(2)
	%        for k = Start(3):Spacing(3):Stop(3)
	%            fprintf(fid, '%14.6f%14.6f%14.6f\n', i, j, k);
	%        end
	%    end
	%end

	% Finishing
	fclose(fid);