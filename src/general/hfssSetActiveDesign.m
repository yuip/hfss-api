function hfssSetActiveDesign(fid, designName)
	% Create the necessary VB Script to insert an HFSS Design into the Project 
	% and set it as the active design.
	%
	% Parameters :
	% fid:			file identifier of the HFSS script file.
	% designName:	name of the new design to be inserted.
	% 
	% @note This function is usually called after a call to hfssOpenProject(), but
	% this is not necessary.
	%
	% Example :
	% @code
	% fid = fopen('myantenna.vbs', 'wt');
	% ...
	% hfssInsertDesign(fid, 'Dipole_SingleElement');
	% @endcode
	%
	% @author James L. McDonald, jlm88byu@gmail.com
	% @date 26 March 2005
	% @author Rounak Singh Narde, rounaksingh17@gmail.com or rn5949@rit.edu
	
	% ----------------------------------------------------------------------------

	% arguments processor.
	if (nargin < 2)
		error('Insufficient number of arguments !');
	end;

	% create the necessary script.
	fprintf(fid, '\n');

	fprintf(fid, 'Set oDesign = oProject.SetActiveDesign("%s")\n', designName);
	fprintf(fid, 'Set oEditor = oDesign.SetActiveEditor("3D Modeler")\n');