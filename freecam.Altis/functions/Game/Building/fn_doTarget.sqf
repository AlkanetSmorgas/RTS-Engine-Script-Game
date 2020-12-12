_type = _this param [0,"",[""]];


_alk_fnc_freeCam_ClickFunction = {
				
	if( (_this select 0) <= 0) then {
		
		_selectedUnits = [] call Alk_Interface_fnc_selected;
		
		if!(_selectedUnits isEqualTo [])then{
		
			if!(alk_fnc_freeCam_specialHover isEqualTo objnull)then{
				_selectedUnits doTarget alk_fnc_freeCam_specialHover;
				_selectedUnits doFire alk_fnc_freeCam_specialHover;
			};
			
			
			alk_fnc_freeCam_specialHover = nil;
			[] call Alk_Interface_fnc_resetClickEvent;
		};

	
	}else{
		alk_fnc_freeCam_specialHover = nil;
		
		[] call Alk_Interface_fnc_resetClickEvent;
	
	};

};

[_alk_fnc_freeCam_ClickFunction] call Alk_Interface_fnc_setClickEvent;


alk_fnc_freeCam_specialHover = objnull;
	
while {sleep 0.1;true} do
{
	if(isNil "alk_fnc_freeCam_specialHover")exitWith{};
	if!(alk_fnc_freeCam_isOpen)exitWith{};
	_mousePos = AGLToASL screentoworld getmouseposition;
	_cam = missionnamespace getvariable ["alk_fnc_freeCam_cam",objnull];
	
	lineIntersectsSurfaces [
	getPosWorld _cam, 
	_mousePos, 
	_cam, objNull, true, 1, "GEOM", "NONE"
	] select 0 params ["","","","_object"];
	if!(isNil "_object")then{
		if!(_object isEqualTo objnull)then{
			if(_object isKindOf "Man" || _object isKindOf "Car")then{
			
				alk_fnc_freeCam_specialHover = _object;
			};
		
		}else{
		
			alk_fnc_freeCam_specialHover = objnull;
		};
	};
	
						
};


