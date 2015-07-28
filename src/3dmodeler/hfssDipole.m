function hfssDipole(fid, Name, Axis, Center, Length, Size, gapLen, ...
                    Units, Type, StrpAxis)
	% function hfssDipole(fid, Name, Axis, Center, Length, Size, gapLen, ...
	%                     Units, [Type], [StrpNrmlAxis])
	% 
	% Creates the VB Script necessary to model a dipole antenna in HFSS. The 
	% dipole can be either a cylinder, a strip or a cuboid.
	%
	% Parameters :
	% fid     - file identifier of the HFSS script file.
	% Name    - name of the dipole (the actual names will appears Name1 and Name2
	%           in the 3D Modeller).
	% Axis    - specify as either 'X', 'Y' or 'Z' - the axis of the dipole.
	% Center  - center of the dipole antenna.
	% Length  - total length of the dipole antenna (including the center gap).
	% Size    - if the dipole is cylindrical (default), this represents the dipole
	%           diameter. Similarly, for a cuboid, Size represents the 
	%           cross-section dimension, and for a strip, Size represents the 
	%           strip width.
	% gapLen  - the length of the dipole gap. 
	% Units   - can be specified as 'in', 'mm', 'meter' or anything else defined 
	%           in HFSS.
	% [Type]  - (optional) type of the dipole. Specify as:
	%           'c' - cylinder (default).
	%           'r' - cuboid.
	%           's' - strip.
	% [StrpNrmlAxis] - (optional) if the dipole type is a strip, then this 
	%                  specifies the axis that is normal to the strip. By default,
	%                  the axis next to 'Axis' in the right-hand sense is taken.
	%                  (i.e., 'X' for 'Z', 'Y' for 'X', ...)
	% 
	% @note Each arm of the dipole will be (Length - gapLen)/2 long.

	% arguments processor.
	if (nargin < 8)
		error('Not enough Arguments !');
	elseif (nargin < 9)
		Type = [];
		StrpAxis = [];
	elseif (nargin < 10)
		StrpAxis = [];
	end;

	% default arguments.
	if isempty(Type)
		Type = 'c';
	end;
	if isempty(StrpAxis)
		switch (Axis)
			case 'X',
				StrpAxis = 'Y';
			case 'Y',
				StrpAxis = 'Z';
			case 'Z',
				StrpAxis = 'X';
		end;
	end;

	if (StrpAxis == Axis)
		error('The Strip Axis and the Antenna Axis cannot be the same !!');
	end;

	Name1 = strcat(Name, '1');
	Name2 = strcat(Name, '2');

	switch Axis,
		case 'X',
			Start1c = Center + [gapLen/2, 0, 0];
			Start2c = Center - [gapLen/2, 0, 0];
			Start1b = Center + [gapLen/2, -Size/2, -Size/2];
			Start2b = Center - [gapLen/2, +Size/2, +Size/2];
			bSize1   = [+(Length - gapLen)/2, Size, Size];
			bSize2   = [-(Length - gapLen)/2, Size, Size];
		case 'Y',
			Start1c = Center + [0, gapLen/2, 0];
			Start2c = Center - [0, gapLen/2, 0];
			Start1b = Center + [-Size/2, gapLen/2, -Size/2];
			Start2b = Center - [+Size/2, gapLen/2, +Size/2];
			bSize1   = [Size, +(Length - gapLen)/2, Size];
			bSize2   = [Size, -(Length - gapLen)/2, Size];
		case 'Z',
			Start1c = Center + [0, 0, gapLen/2];
			Start2c = Center - [0, 0, gapLen/2];
			Start1b = Center + [-Size/2, -Size/2, -gapLen/2];
			Start2b = Center - [+Size/2, +Size/2, -gapLen/2];
			bSize1   = [Size, Size, +(Length - gapLen)/2];
			bSize2   = [Size, Size, -(Length - gapLen)/2];
	end;

	switch(Type)
		case 'c',
			hfssCylinder(fid, Name1, Axis, Start1c, Size/2, ...
			             (Length - gapLen)/2, Units);
			hfssCylinder(fid, Name2, Axis, Start2c, Size/2, ...
			            -(Length - gapLen)/2, Units);
		case 'r',
			hfssBox(fid, Name1, Start1b, bSize1, Units);
			hfssBox(fid, Name2, Start2b, bSize2, Units);
		case 's',
			% A Whole new ball game altogether here.
			switch Axis
				case 'X',
					switch StrpAxis
						case 'Y',
							sStart1 = Center + [gapLen/2, 0, -Size/2];
							sStart2 = Center - [gapLen/2, 0, +Size/2];
							Width1 = Size; Width2 = Size;
							Height1 = Length - gapLen/2; Height2 = -Height1;
						case 'Z',
							sStart1 = Center + [gapLen/2, -Size/2, 0];
							sStart2 = Center - [gapLen/2, +Size/2, 0];
							Width1 = Length - gapLen/2; Width2 = - Width1;
							Height1 = Size; Height2 = Size;
					end;
				case 'Y',
					switch StrpAxis
						case 'Z',
							sStart1 = Center + [-Size/2, gapLen/2, 0];
							sStart2 = Center - [+Size/2, gapLen/2, 0];
							Width1 = Size; Width2 = Size;
							Height1 = Length - gapLen/2; Height2 = -Height1;
						case 'X',
							sStart1 = Center + [0, gapLen/2, -Size/2];
							sStart2 = Center - [0, gapLen/2, +Size/2];
							Width1 = Length - gapLen/2; Width2 = -Width1;
							Height1 = Size; Height2 = Size;
					end;
				case 'Z',
					switch StrpAxis
						case 'Y',
							sStart1 = Center + [-Size/2, 0,gapLen/2];
							sStart2 = Center - [+Size/2, 0,gapLen/2];
							Width1 = Length - gapLen/2; Width2 = - Width1;
							Height1 = Size; Height2 = Size;
						case 'X',
							sStart1 = Center + [0, -Size/2, gapLen/2];
							sStart2 = Center - [0, +Size/2, gapLen/2];
							Width1 = Size; Width2 = Size;
							Height1 = Length - gapLen/2; Height2 = - Height1;
					end;
			end;
			hfssRectangle(fid, Name1, StrpAxis, sStart1, Width1, Height1, Units);
			hfssRectangle(fid, Name2, StrpAxis, sStart2, Width2, Height2, Units);
	end;		
