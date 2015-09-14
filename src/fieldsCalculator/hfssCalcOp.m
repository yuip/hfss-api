function hfssCalcOp(fid, Op)
	% Performs a calculator operation.
	%
	% Parameters :
	% fid:	file identifier of the HFSS script file.
	% Op:	operation to be performed.
	% 
	% Example :
	% @code
	% hfssCalcOp(fid, 'Smooth');
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
	fprintf(fid, 'oModule.CalcOp "%s"\n', Op);