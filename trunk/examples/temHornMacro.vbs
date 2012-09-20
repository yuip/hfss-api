Dim oHfssApp
Dim oDesktop
Dim oProject
Dim oDesign
Dim oEditor
Dim oModule

Set oHfssApp  = CreateObject("AnsoftHfss.HfssScriptInterface")
Set oDesktop = oHfssApp.GetAppDesktop()
oDesktop.RestoreWindow
oDesktop.NewProject
Set oProject = oDesktop.GetActiveProject

oProject.InsertDesign "HFSS", "Basic", "DrivenModal", ""
Set oDesign = oProject.SetActiveDesign("Basic")
Set oEditor = oDesign.SetActiveEditor("3D Modeler")

oEditor.CreateBox _
Array("NAME:BoxParameters", _
"XPosition:=", "-1359.500000mm", _
"YPosition:=", "-1542.000000mm", _
"ZPosition:=", "-2448.000000mm", _
"XSize:=", "2974.500000mm", _
"YSize:=", "3084.000000mm", _
"ZSize:=", "4896.000000mm"), _
Array("NAME:Attributes", _
"Name:=", "AirBox", _
"Flags:=", "", _
"Color:=", "(132 132 193)", _
"Transparency:=", 0.75, _
"PartCoordinateSystem:=", "Global", _
"MaterialName:=", "vacuum", _
"SolveInside:=", true)
Set oModule = oDesign.GetModule("BoundarySetup")
oModule.AssignRadiation _
Array("NAME:ABC", _
"Objects:=", Array("AirBox"))

oEditor.ChangeProperty _
Array("NAME:AllTabs", _
	Array("NAME:Geometry3DAttributeTab", _
		Array("NAME:PropServers","AirBox"), _
		Array("NAME:ChangedProps", _
			Array("NAME:Transparent", "Value:=",  0.950000) _
			) _
		) _
	)

oEditor.CreateBox _
Array("NAME:BoxParameters", _
"XPosition:=", "365.000000mm", _
"YPosition:=", "-1542.000000mm", _
"ZPosition:=", "-2448.000000mm", _
"XSize:=", "1250.000000mm", _
"YSize:=", "3084.000000mm", _
"ZSize:=", "4896.000000mm"), _
Array("NAME:Attributes", _
"Name:=", "SnowBox", _
"Flags:=", "", _
"Color:=", "(132 132 193)", _
"Transparency:=", 0.75, _
"PartCoordinateSystem:=", "Global", _
"MaterialName:=", "vacuum", _
"SolveInside:=", true)

oEditor.ChangeProperty _
Array("NAME:AllTabs", _
	Array("NAME:Geometry3DAttributeTab", _
		Array("NAME:PropServers","SnowBox"), _
		Array("NAME:ChangedProps", _
			Array("NAME:Transparent", "Value:=",  0.850000) _
			) _
		) _
	)

oProject.AddMaterial _
Array("NAME:Snow", _
"permittivity:=", "1.700000", _
"conductivity:=", "0.000000", _
"dielectric_loss_tangent:=", "0.000000")

oEditor.AssignMaterial _
	Array("NAME:Selections", _
		"Selections:=", "SnowBox"), _
	Array("NAME:Attributes", _
		"MaterialName:=", "Snow", _
		"SolveInside:=", true)

oEditor.CreatePolyline _
	Array("NAME:PolylineParameters", "IsPolylineCovered:=", true, "IsPolylineClosed:=", false, _
		Array("NAME:PolylinePoints", _
			Array("NAME:PLPoint", "X:=", "0.0000mm", "Y:=", "27.5210mm", "Z:=", "5.8400mm"), _
			Array("NAME:PLPoint", "X:=", "36.5000mm", "Y:=", "34.6020mm", "Z:=", "7.6650mm"), _
			Array("NAME:PLPoint", "X:=", "73.0000mm", "Y:=", "43.8000mm", "Z:=", "10.9500mm"), _
			Array("NAME:PLPoint", "X:=", "109.5000mm", "Y:=", "55.8450mm", "Z:=", "15.6950mm"), _
			Array("NAME:PLPoint", "X:=", "146.0000mm", "Y:=", "70.8100mm", "Z:=", "24.4550mm"), _
			Array("NAME:PLPoint", "X:=", "182.5000mm", "Y:=", "89.4250mm", "Z:=", "34.6750mm"), _
			Array("NAME:PLPoint", "X:=", "219.0000mm", "Y:=", "113.1500mm", "Z:=", "52.5600mm"), _
			Array("NAME:PLPoint", "X:=", "255.5000mm", "Y:=", "143.4450mm", "Z:=", "80.3000mm"), _
			Array("NAME:PLPoint", "X:=", "292.0000mm", "Y:=", "181.7700mm", "Z:=", "123.3700mm"), _
			Array("NAME:PLPoint", "X:=", "328.5000mm", "Y:=", "229.9500mm", "Z:=", "190.1650mm"), _
			Array("NAME:PLPoint", "X:=", "365.0000mm",   "Y:=", "292.0000mm",   "Z:=", "292.0000mm")_
			), _ 
		Array("NAME:PolylineSegments", _
			Array("NAME:PLSegment", "SegmentType:=",  "Spline", "StartIndex:=", 0, "NoOfPoints:=", 11) _
			) _
		), _
Array("NAME:Attributes", _
"Name:=", "HornEdge1", _
"Flags:=", "", _
"Color:=", "(0 0 0)", _
"Transparency:=", 0.800000, _
"PartCoordinateSystem:=", "Global", _
"MaterialName:=", "vacuum", _
"SolveInside:=", true)

oEditor.CreatePolyline _
	Array("NAME:PolylineParameters", "IsPolylineCovered:=", true, "IsPolylineClosed:=", false, _
		Array("NAME:PolylinePoints", _
			Array("NAME:PLPoint", "X:=", "0.0000mm", "Y:=", "-27.5210mm", "Z:=", "5.8400mm"), _
			Array("NAME:PLPoint", "X:=", "36.5000mm", "Y:=", "-34.6020mm", "Z:=", "7.6650mm"), _
			Array("NAME:PLPoint", "X:=", "73.0000mm", "Y:=", "-43.8000mm", "Z:=", "10.9500mm"), _
			Array("NAME:PLPoint", "X:=", "109.5000mm", "Y:=", "-55.8450mm", "Z:=", "15.6950mm"), _
			Array("NAME:PLPoint", "X:=", "146.0000mm", "Y:=", "-70.8100mm", "Z:=", "24.4550mm"), _
			Array("NAME:PLPoint", "X:=", "182.5000mm", "Y:=", "-89.4250mm", "Z:=", "34.6750mm"), _
			Array("NAME:PLPoint", "X:=", "219.0000mm", "Y:=", "-113.1500mm", "Z:=", "52.5600mm"), _
			Array("NAME:PLPoint", "X:=", "255.5000mm", "Y:=", "-143.4450mm", "Z:=", "80.3000mm"), _
			Array("NAME:PLPoint", "X:=", "292.0000mm", "Y:=", "-181.7700mm", "Z:=", "123.3700mm"), _
			Array("NAME:PLPoint", "X:=", "328.5000mm", "Y:=", "-229.9500mm", "Z:=", "190.1650mm"), _
			Array("NAME:PLPoint", "X:=", "365.0000mm",   "Y:=", "-292.0000mm",   "Z:=", "292.0000mm")_
			), _ 
		Array("NAME:PolylineSegments", _
			Array("NAME:PLSegment", "SegmentType:=",  "Spline", "StartIndex:=", 0, "NoOfPoints:=", 11) _
			) _
		), _
Array("NAME:Attributes", _
"Name:=", "HornEdge2", _
"Flags:=", "", _
"Color:=", "(0 0 0)", _
"Transparency:=", 0.800000, _
"PartCoordinateSystem:=", "Global", _
"MaterialName:=", "vacuum", _
"SolveInside:=", true)

oEditor.Connect _
Array("NAME:Selections", _
"Selections:=", _
"HornEdge1,HornEdge2")

oEditor.ChangeProperty _
Array("NAME:AllTabs", _
Array("NAME:Geometry3DAttributeTab", _
Array("NAME:PropServers", "HornEdge1"), _
Array("NAME:ChangedProps", _
Array("NAME:Name", _
"Value:=", "HornPlate1"))))

oEditor.CreateRectangle _
Array("NAME:RectangleParameters", _
"IsCovered:=", true, _
"XStart:=", "0.000000mm", _
"YStart:=", "27.521000mm", _
"ZStart:=", "5.840000mm", _
"Width:=", "-109.500000mm", _
"Height:=", "-55.042000mm", _
"WhichAxis:=", "Z"), _
Array("NAME:Attributes", _
"Name:=", "RectFeed1", _
"Flags:=", "", _
"Color:=", "(132 132 193)", _
"Transparency:=", 5.000000e-001, _
"PartCoordinateSystem:=", "Global", _
"MaterialName:=", "vacuum", _
"SolveInside:=", true)

oEditor.Unite  _
Array("NAME:Selections", _
"Selections:=", "HornPlate1,RectFeed1"), _
Array("NAME:UniteParameters", "KeepOriginals:=", false)

Set oModule = oDesign.GetModule("BoundarySetup")
oModule.AssignPerfectE _
Array("NAME:AntennaMetal", _
"InfGroundPlane:=", false, _
"Objects:=", _
Array("HornPlate1"))
oEditor.DuplicateMirror _
	Array("NAME:Selections", "Selections:=", "HornPlate1"), _
	Array("NAME:DuplicateToMirrorParameters", _
		"DuplicateMirrorBaseX:=",  "0.000000mm", _
		"DuplicateMirrorBaseY:=", "0.000000mm", _
		"DuplicateMirrorBaseZ:=", "0.000000mm", _
		"DuplicateMirrorNormalX:=",  "0.000000mm", _
		"DuplicateMirrorNormalY:=", "0.000000mm", _
		"DuplicateMirrorNormalZ:=", "-1.000000mm" _
		), _
	Array("NAME:Options", "DuplicateBoundaries:=", true) 


oEditor.CreateCylinder _
Array("NAME:CylinderParameters", _
"XCenter:=", "-94.900000mm", _
"YCenter:=", "0.000000mm", _
"ZCenter:=", "-58.400000mm", _
"Radius:=", "1.524000mm", _
"Height:=", "64.240000mm", _
"WhichAxis:=", "Z"), _
Array("NAME:Attributes", _
"Name:=", "coaxInner", _
"Flags:=", "", _
"Color:=", "(132 132 193)", _
"Transparency:=", 0, _
"PartCoordinateSystem:=", "Global", _
"MaterialName:=", "vacuum", _
"SolveInside:=", true)


oEditor.CreateCylinder _
Array("NAME:CylinderParameters", _
"XCenter:=", "-94.900000mm", _
"YCenter:=", "0.000000mm", _
"ZCenter:=", "-58.400000mm", _
"Radius:=", "4.953000mm", _
"Height:=", "52.560000mm", _
"WhichAxis:=", "Z"), _
Array("NAME:Attributes", _
"Name:=", "coaxOuter", _
"Flags:=", "", _
"Color:=", "(132 132 193)", _
"Transparency:=", 0, _
"PartCoordinateSystem:=", "Global", _
"MaterialName:=", "vacuum", _
"SolveInside:=", true)


oEditor.CreateCylinder _
Array("NAME:CylinderParameters", _
"XCenter:=", "-94.900000mm", _
"YCenter:=", "0.000000mm", _
"ZCenter:=", "-58.400000mm", _
"Radius:=", "1.524000mm", _
"Height:=", "52.560000mm", _
"WhichAxis:=", "Z"), _
Array("NAME:Attributes", _
"Name:=", "coaxOuter_sub", _
"Flags:=", "", _
"Color:=", "(132 132 193)", _
"Transparency:=", 0, _
"PartCoordinateSystem:=", "Global", _
"MaterialName:=", "vacuum", _
"SolveInside:=", true)


oEditor.Subtract _
Array("NAME:Selections", _
"Blank Parts:=", _
"coaxOuter", _
"Tool Parts:=", _
"coaxOuter_sub"), _
Array("NAME:SubtractParameters", _
"KeepOriginals:=", false) 
oEditor.CreateCircle _
Array("NAME:CircleParameters", _
"IsCovered:=", false, _
"XCenter:=", "-94.900000mm", _
"YCenter:=", "0.000000mm", _
"ZCenter:=", "-58.400000mm", _
"Radius:=", "4.953000mm", _
"WhichAxis:=", "Z"), _
Array("NAME:Attributes", _
"Name:=", "coaxOuterCover_Edge1", _
"Flags:=", "", _
"Color:=", "(132 132 193)", _
"Transparency:=", 0, _
"PartCoordinateSystem:=", "Global", _
"MaterialName:=", "vacuum", _
"SolveInside:=", true)
oEditor.CreateCircle _
Array("NAME:CircleParameters", _
"IsCovered:=", false, _
"XCenter:=", "-94.900000mm", _
"YCenter:=", "0.000000mm", _
"ZCenter:=", "-5.840000mm", _
"Radius:=", "4.953000mm", _
"WhichAxis:=", "Z"), _
Array("NAME:Attributes", _
"Name:=", "coaxOuterCover_Edge2", _
"Flags:=", "", _
"Color:=", "(132 132 193)", _
"Transparency:=", 0, _
"PartCoordinateSystem:=", "Global", _
"MaterialName:=", "vacuum", _
"SolveInside:=", true)

oEditor.Connect _
Array("NAME:Selections", _
"Selections:=", _
"coaxOuterCover_Edge1,coaxOuterCover_Edge2")

oEditor.ChangeProperty _
Array("NAME:AllTabs", _
Array("NAME:Geometry3DAttributeTab", _
Array("NAME:PropServers", "coaxOuterCover_Edge1"), _
Array("NAME:ChangedProps", _
Array("NAME:Name", _
"Value:=", "coaxOuterCover"))))

Set oModule = oDesign.GetModule("BoundarySetup")
oModule.AssignPerfectE _
Array("NAME:FeedMetals", _
"InfGroundPlane:=", false, _
"Objects:=", _
Array("coaxOuterCover"))

oEditor.AssignMaterial _
	Array("NAME:Selections", _
		"Selections:=", "coaxInner"), _
	Array("NAME:Attributes", _
		"MaterialName:=", "pec", _
		"SolveInside:=", false)

oEditor.AssignMaterial _
	Array("NAME:Selections", _
		"Selections:=", "coaxOuter"), _
	Array("NAME:Attributes", _
		"MaterialName:=", "Teflon (tm)", _
		"SolveInside:=", true)
oEditor.CreateCircle _
Array("NAME:CircleParameters", _
"IsCovered:=", true, _
"XCenter:=", "-94.900000mm", _
"YCenter:=", "0.000000mm", _
"ZCenter:=", "5.840000mm", _
"Radius:=", "1.524000mm", _
"WhichAxis:=", "Z"), _
Array("NAME:Attributes", _
"Name:=", "HornPlate1_FeedCut", _
"Flags:=", "", _
"Color:=", "(132 132 193)", _
"Transparency:=", 0, _
"PartCoordinateSystem:=", "Global", _
"MaterialName:=", "vacuum", _
"SolveInside:=", true)
oEditor.CreateCircle _
Array("NAME:CircleParameters", _
"IsCovered:=", true, _
"XCenter:=", "-94.900000mm", _
"YCenter:=", "0.000000mm", _
"ZCenter:=", "-5.840000mm", _
"Radius:=", "4.953000mm", _
"WhichAxis:=", "Z"), _
Array("NAME:Attributes", _
"Name:=", "HornPlate2_FeedCut", _
"Flags:=", "", _
"Color:=", "(132 132 193)", _
"Transparency:=", 0, _
"PartCoordinateSystem:=", "Global", _
"MaterialName:=", "vacuum", _
"SolveInside:=", true)

oEditor.Subtract _
Array("NAME:Selections", _
"Blank Parts:=", _
"HornPlate1", _
"Tool Parts:=", _
"HornPlate1_FeedCut"), _
Array("NAME:SubtractParameters", _
"KeepOriginals:=", false) 

oEditor.Subtract _
Array("NAME:Selections", _
"Blank Parts:=", _
"HornPlate1_1", _
"Tool Parts:=", _
"HornPlate2_FeedCut"), _
Array("NAME:SubtractParameters", _
"KeepOriginals:=", false) 
oEditor.CreateCircle _
Array("NAME:CircleParameters", _
"IsCovered:=", true, _
"XCenter:=", "-94.900000mm", _
"YCenter:=", "0.000000mm", _
"ZCenter:=", "-58.400000mm", _
"Radius:=", "4.953000mm", _
"WhichAxis:=", "Z"), _
Array("NAME:Attributes", _
"Name:=", "PortCircle", _
"Flags:=", "", _
"Color:=", "(132 132 193)", _
"Transparency:=", 0, _
"PartCoordinateSystem:=", "Global", _
"MaterialName:=", "vacuum", _
"SolveInside:=", true)

Set oModule = oDesign.GetModule("BoundarySetup") 

oModule.AssignWavePort _
Array( _
"NAME:Port1", _
"NumModes:=", 1, _
"PolarizeEField:=",  false, _
"DoDeembed:=", false, _
"DoRenorm:=", false, _
Array("NAME:Modes", _
Array("NAME:Mode1", _
"ModeNum:=",  1, _
"UseIntLine:=", false) _
), _
"Objects:=", Array("PortCircle")) 

oEditor.CreateCylinder _
Array("NAME:CylinderParameters", _
"XCenter:=", "-94.900000mm", _
"YCenter:=", "0.000000mm", _
"ZCenter:=", "-58.400000mm", _
"Radius:=", "4.953000mm", _
"Height:=", "-0.100000mm", _
"WhichAxis:=", "Z"), _
Array("NAME:Attributes", _
"Name:=", "PortCap", _
"Flags:=", "", _
"Color:=", "(132 132 193)", _
"Transparency:=", 0, _
"PartCoordinateSystem:=", "Global", _
"MaterialName:=", "vacuum", _
"SolveInside:=", true)


oEditor.AssignMaterial _
	Array("NAME:Selections", _
		"Selections:=", "PortCap"), _
	Array("NAME:Attributes", _
		"MaterialName:=", "pec", _
		"SolveInside:=", false)

oEditor.Move _
Array("NAME:Selections", _
"Selections:=", "HornPlate1,HornPlate1_1,PortCircle,coaxInner,coaxOuterCover,coaxOuter,PortCap"), _
Array("NAME:TranslateParameters", _
"TranslateVectorX:=", "0.000000mm", _
"TranslateVectorY:=", "0.000000mm", _
"TranslateVectorZ:=", "-906.000000mm")

oEditor.DuplicateAlongLine _
Array("NAME:Selections", _
"Selections:=", "HornPlate1,HornPlate1_1,PortCircle,coaxInner,coaxOuterCover,coaxOuter,PortCap"), _
Array("NAME:DuplicateToAlongLineParameters", _
"XComponent:=", "0.000000mm", _
"YComponent:=", "0.000000mm", _
"ZComponent:=", "604.000000mm", _
"NumClones:=", 4), _
Array("NAME:Options", _
"DuplicateBoundaries:=", true)

Set oModule = oDesign.GetModule("AnalysisSetup")
oModule.InsertSetup "HfssDriven", _
Array("NAME:Setup120MHz", _
"Frequency:=", "0.120000GHz", _
"PortsOnly:=", false, _
"maxDeltaS:=", 0.020000, _
"UseMatrixConv:=", false, _
"MaximumPasses:=", 25, _
"MinimumPasses:=", 1, _
"MinimumConvergedPasses:=", 1, _
"PercentRefinement:=", 20, _
"ReducedSolutionBasis:=", false, _
"DoLambdaRefine:=", true, _
"DoMaterialLambda:=", true, _
"Target:=", 0.3333, _
"PortAccuracy:=", 2, _
"SetPortMinMaxTri:=", false)

Set oModule = oDesign.GetModule("AnalysisSetup")
oModule.InsertSetup "HfssDriven", _
Array("NAME:Setup150MHz", _
"Frequency:=", "0.150000GHz", _
"PortsOnly:=", false, _
"maxDeltaS:=", 0.020000, _
"UseMatrixConv:=", false, _
"MaximumPasses:=", 25, _
"MinimumPasses:=", 1, _
"MinimumConvergedPasses:=", 1, _
"PercentRefinement:=", 20, _
"ReducedSolutionBasis:=", false, _
"DoLambdaRefine:=", true, _
"DoMaterialLambda:=", true, _
"Target:=", 0.3333, _
"PortAccuracy:=", 2, _
"SetPortMinMaxTri:=", false)

Set oModule = oDesign.GetModule("AnalysisSetup")
oModule.InsertSetup "HfssDriven", _
Array("NAME:Setup225MHz", _
"Frequency:=", "0.225000GHz", _
"PortsOnly:=", false, _
"maxDeltaS:=", 0.020000, _
"UseMatrixConv:=", false, _
"MaximumPasses:=", 25, _
"MinimumPasses:=", 1, _
"MinimumConvergedPasses:=", 1, _
"PercentRefinement:=", 20, _
"ReducedSolutionBasis:=", false, _
"DoLambdaRefine:=", true, _
"DoMaterialLambda:=", true, _
"Target:=", 0.3333, _
"PortAccuracy:=", 2, _
"SetPortMinMaxTri:=", false)

Set oModule = oDesign.GetModule("AnalysisSetup")
oModule.InsertSetup "HfssDriven", _
Array("NAME:Setup300MHz", _
"Frequency:=", "0.300000GHz", _
"PortsOnly:=", false, _
"maxDeltaS:=", 0.020000, _
"UseMatrixConv:=", false, _
"MaximumPasses:=", 25, _
"MinimumPasses:=", 1, _
"MinimumConvergedPasses:=", 1, _
"PercentRefinement:=", 20, _
"ReducedSolutionBasis:=", false, _
"DoLambdaRefine:=", true, _
"DoMaterialLambda:=", true, _
"Target:=", 0.3333, _
"PortAccuracy:=", 2, _
"SetPortMinMaxTri:=", false)

oProject.SaveAs _
    "C:\Vijay\temHornEPlaneArraySnow.hfss", _
    true
