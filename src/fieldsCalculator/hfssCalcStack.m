function hfssCalcStack(fid, Op)
	% Performs an operation on the stack.
	%
	% Parameters :
	% fid:	file identifier of the HFSS script file.
	% Op:	operation to be performed.
	% 
	% Example :
	% @code
	% hfssCalcOp(fid, 'clear');
	% @endcode
	%
	% @author Daniel R. Prado, danysan@gmail.com / drprado@tsc.uniovi.es
	% @date 05 November 2012

	% ----------------------------------------------------------------------------
	% CHANGELOG
	%
	% 05-Nov-2012: *Initial release.
	% ----------------------------------------------------------------------------
	
	% Arguments processor.
	if (nargin < 2)
		error('Insufficient # of arguments !');
	end

	% Preamble
	fprintf(fid, '\n');
	fprintf(fid, 'Set oModule = oDesign.GetModule("FieldsReporter")\n');

	% Command
	fprintf(fid, 'oModule.CalcStack "%s"\n', Op);