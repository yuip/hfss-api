function hfssEnterQty(fid, Qty)
	% Adds a field quantity to the fields calculator's stack.
	%
	% Parameters :
	% fid:	file identifier of the HFSS script file.
	% Qty:	field quantity to be entered onto the stack.
	% 
	% Example :
	% @code
	% hfssEnterQty(fid, 'E');
	% hfssEnterQty(fid, 'H');
	% @endcode
	% 
	% @author Daniel R. Prado, danysan@gmail.com / drprado@tsc.uniovi.es
	% @date 06 October 2012
	
	% ----------------------------------------------------------------------------
	% CHANGELOG
	%
	% 06-Oct-2012: *Initial release.
	% ----------------------------------------------------------------------------

	% Arguments processor.
	if (nargin < 2)
		error('Insufficient # of arguments !');
	end

	% Preamble
	fprintf(fid, '\n');
	fprintf(fid, 'Set oModule = oDesign.GetModule("FieldsReporter")\n');

	% Command
	fprintf(fid, 'oModule.EnterQty "%s"\n', Qty);