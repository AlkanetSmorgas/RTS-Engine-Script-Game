_pos = _this param [0,[],[[]]];
_button = _this param [1,-1,[0]];


if( _button <= 0) then {
	
	[] call Alk_Interface_fnc_unSelect;
	["Rsc_RTS_Main"] call Alk_Interface_fnc_createSubMenu;

};

//Hover over building
if!(alk_fnc_freeCam_HOVEREDobject isEqualTo objnull)then{
	_building = alk_fnc_freeCam_HOVEREDobject;
	_gameType = _building getvariable ["_gameType",-1];

	switch (_gameType) do {

		//Building
		case 0: {
			if( _button <= 0) then {
				_type = _building getvariable ["_type",""];
				_submenu = getText (missionConfigFile >> "Rsc_RTS_Main_Buildings" >> _type >> "submenu");
				alk_fnc_freeCam_SELECTEDbuilding = _building;

				[_submenu] call Alk_Interface_fnc_createSubMenu;
			};
		};
		
		//CapturePoint
		case 1: {
			if( _button > 0) then {
				if !(alk_fnc_freeCam_SELECTEDobject isEqualTo []) then{
					_group = group (alk_fnc_freeCam_SELECTEDobject select 0);
					_leader = leader _group;
					_captureBuilding =_group getVariable ["captureBuilding",objnull];
					_belongsTo = _building getvariable ["_belongsTo",civilian];
					if!(_belongsTo isEqualTo side player)then{
						if!(_captureBuilding isEqualTo _building)then{
							[_captureBuilding,_group] remoteExec ["Alk_Objective_fnc_capture_stop", 2]; 	
							_group setVariable ["captureBuilding",objnull];		
								
						};
						
						
						[_building,alk_fnc_freeCam_SELECTEDobject] remoteExec ["Alk_Objective_fnc_capture_server", 2]; 	
						
						
					};		
				};
			};
		};
		//Unit
		case 2: {
			if( _button <= 0) then {
				_isAI = _building getvariable ["_isAI",false];
				if(local _building && !_isAI)then{
					[units group _building] call Alk_Interface_fnc_select;
				};
			};
			
			if( _button > 0) then {
				_selectedUnits = [] call Alk_Interface_fnc_selected;
				if!(_selectedUnits isEqualTo [])then{
					
					_grp = group (_selectedUnits select 0);
					_grp2 = group _building;
					aiStopStalk = false;
					currentMoveTo = leader _grp2;
					_grp setVariable ["doMove",leader _grp2];	
					[_grp, _grp2, nil, nil, { aiStopStalk }] spawn BIS_fnc_stalk;
					
				};
			};
		};
		
		
		
		
		default {};
	};
}else{
	//Ground
	if( _button > 0) then {

			_selectedUnits = [] call Alk_Interface_fnc_selected;
			[_selectedUnits,screentoworld getmouseposition] call Alk_AI_fnc_move;
			_group = group (_selectedUnits select 0);
			_captureBuilding =_group getVariable ["captureBuilding",objnull];
			if!(_captureBuilding isEqualTo objnull)then{
				[_captureBuilding,_group] remoteExec ["Alk_Objective_fnc_capture_stop", 2]; 	
				_group setVariable ["captureBuilding",objnull];		
				
			};
		
	};

};




