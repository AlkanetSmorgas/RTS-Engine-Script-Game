
if (isNil "alk_fnc_freeCam_SELECTEDobject") exitWith{};

if!(alk_fnc_freeCam_SELECTEDobject isEqualTo [])then{
	alk_fnc_freeCam_SELECTEDobject = [];
	_ctrl = uiNamespace getvariable ["alk_fnc_freeCam_unitArrayCtrl",controlnull];
	

	_ctrl tvSetCurSel [-1];
	
	currentMoveTo = [];

};