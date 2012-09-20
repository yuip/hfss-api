' ----------------------------------------------
' Script Recorded by Ansoft HFSS Version 9.1
' 5:38 PM  May 27, 2005
' ----------------------------------------------
Dim oHfssApp
Dim oDesktop
Dim oProject
Dim oDesign
Dim oEditor
Dim oModule
Set oHfssApp  = CreateObject("AnsoftHfss.HfssScriptInterface")
Set oDesktop = oHfssApp.GetAppDesktop()
oDesktop.RestoreWindow
Set oProject = oDesktop.SetActiveProject("4_rx_e")
Set oDesign = oProject.SetActiveDesign("TEM_Korean_Coax_Scale")
Set oEditor = oDesign.SetActiveEditor("3D Modeler")


oEditor.ChangeProperty 
	Array("NAME:AllTabs", 
		Array("NAME:Geometry3DAttributeTab", 
			Array("NAME:PropServers",  "Cylinder2"), 
			Array("NAME:ChangedProps", 
				Array("NAME:Solve Inside", "Value:=", false)
				)
			)
		)
