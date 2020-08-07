function hfssUncoveredCylinder(fid, Name, Axis, Center, Radius, Height, Units)

Center1 = Center;
Center2 = Center;
switch(Axis)
	case 'X', 
		Center2(1) = Center2(1) + Height;
	case 'Y',
		Center2(2) = Center2(2) + Height;
	case 'Z',
		Center2(3) = Center2(3) + Height;
end;

% create circles
cName1 = strcat(Name, '_Edge1');
cName2 = strcat(Name, '_Edge2');
hfssCircle(fid, cName1, Axis, Center1, Radius, Units, false);
hfssCircle(fid, cName2, Axis, Center2, Radius, Units, false);

% ... and connect them.
hfssConnect(fid, {cName1, cName2});
hfssRename(fid, cName1, Name);
