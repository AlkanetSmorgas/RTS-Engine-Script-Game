_aiUnits = [];

if (isNil "RTS_server_AI_bluforAmount") then{
	server_AI_ignoreMaxAI = true;
	RTS_server_AI_bluforAmount = 0;
	RTS_server_AI_opforAmount = 0;
}else{
	server_AI_ignoreMaxAI = false;
};

_bluforAmount = 0;
_opforAmount = 0;
{
	if(! (isPlayer _x) ) then {
		_side = side _x;
		_maxAI = if (_side isEqualTo blufor) then {RTS_server_AI_bluforAmount} else {RTS_server_AI_opforAmount};
		_sideToTest = if (_side isEqualTo blufor) then {_bluforAmount} else {_opforAmount};
		
		if(_sideToTest < _maxAI || server_AI_ignoreMaxAI)then{
			_logicGroup = createGroup side _x;
			_logic = _logicGroup createUnit ["Logic", [0,0,0], [], 0, "NONE"];
			_aiUnits pushBack _logic;
			
			
			_logic setvariable ["alk_fnc_side",_side];
			
			
			if(_side isEqualTo blufor)then{
			
				private _myNewArray = +(resourceArrayServer select 0) apply {0};
				_logic setvariable ["alk_fnc_resourcesSpent",_myNewArray];
				_bluforAmount = _bluforAmount + 1;
			}else{
				private _myNewArray = +(resourceArrayServer select 1) apply {0};
				_logic setvariable ["alk_fnc_resourcesSpent",_myNewArray];
				_opforAmount = _opforAmount + 1;
			};
			
			_logic setvariable ["alk_fnc_buildings",[]];
		};
		
		deleteVehicle _x;
	};
} foreach (if (isMultiplayer) then {playableUnits} else {switchableUnits});


		
if!(_aiUnits isEqualTo [])then{

	alk_ai_fnc_createGroup = {
	_side = _this param [0,blufor,[blufor]];
	_type = _this param [1,"",[""]];
	_building = _this param [2,objnull,[objnull]];

	
	_group = createGroup [_side, true];

	_dimenson = (sizeOf typeof _building) * 0.5;

	if(_dimenson isEqualTo 0)then{_dimenson = 10;};

	_pos = [_building, _dimenson, _dimenson+2, 1, 0, 20, 0] call BIS_fnc_findSafePos;
	_hasVehicle = false;
	_veh = objnull;
	
	
	
	{
		_vehicle = getText (_x >> "vehicle");
		
		_isVehicle = getNumber(configFile >> "CfgVehicles" >> _vehicle >> "isMan") == 0;

		if(_isVehicle)then{
			_veh = createvehicle [_vehicle,_pos,[],0,"none"];
			_group addVehicle _veh;
			_hasVehicle = true;
		}else{
			_unit = _group createUnit [_vehicle, _pos, [], 0, "FORM"];
			_unit setSkill 1;
			_unit allowFleeing 0;
			_unit setvariable ["_gameType",2,true];
			_unit setvariable ["_isAI",true,true];
		};
		
		
	} foreach (configproperties [missionConfigFile >> "Rsc_RTS_Main_Units" >> _type >> str _side,"isclass _x"]);

	if(_hasVehicle)then{
		{_x moveInAny _veh;}foreach units _group;
	};

	[_group] remoteExec ["Alk_Building_fnc_addGroupToAll", 0]; 
	
	
	_group;
	};
	
	

	alk_ai_fnc_didBuy = {
		_costArray = _this param [0,[],[[]]];
		_aiSide = _this param [1,blufor,[blufor]];
		_resourcesSpent = _this param [2,[],[[]]];			

		_didBuy = false;
		_validateBuy = true;

		_sideValue = if(_aiSide isEqualTo opfor)then{(resourceArrayServer select 1)}else{(resourceArrayServer select 0)};



		for "_i" from 0 to (count _costArray - 1) step 2 do {
			_name = _costArray select _i;
			_value = _costArray select (_i+1);
			
			_currentValue = 0;
			_resourceIndex = resourceData findIf {(_x select 0) isEqualTo _name};

			_currentSpending = _resourcesSpent select _resourceIndex;
			if(_resourceIndex >= 0)then{
				_currentValue = _sideValue select _resourceIndex;
			};
			
			if((_currentValue - _currentSpending) < _value)then{
				_validateBuy = false;		
			};
		};

		if(_validateBuy)then{
			_didBuy = true;
				for "_i" from 0 to (count _costArray - 1) step 2 do {
					_name = _costArray select _i;
					_value = _costArray select (_i+1);
					_currentValue = 0;
					_resourceIndex = resourceData findIf {(_x select 0) isEqualTo _name};

					_currentSpending = _resourcesSpent select _resourceIndex;
					
					_resourcesSpent set [_resourceIndex,_currentSpending+_value];
				
					
				};
		};
		_didBuy;
	};

	_capturePointCloseBlufor = allCapturePoints apply { [_x distance Blufor_spawn, _x] };
	_capturePointCloseBlufor sort true;

	_capturePointCloseOpfor = allCapturePoints apply { [_x distance Opfor_spawn, _x] };
	_capturePointCloseOpfor sort true;
	

	_buildingConfig = (configproperties [missionConfigFile >> "Rsc_RTS_Main_Buildings","isclass _x"]);
	_maxBuildings = count _buildingConfig;
	 

	while {true} do
	{

		sleep 2;
		
		{
			_logic = _x;
			_groups = _logic getvariable ["alk_fnc_groups",[]];
			
			_aiSide = _logic getvariable ["alk_fnc_side",civilian];
			_buildings = _logic getvariable ["alk_fnc_buildings",[]];
			_resourcesSpent = _logic getvariable ["alk_fnc_resourcesSpent",[]];
			_checkTimer = _logic getvariable ["alk_fnc_checkTimer",time];
			
				
			
		

			
				//Buy buildings code
				_currentBuildings = count _buildings;
				
				if(_currentBuildings < _maxBuildings)then{
					
					_newBuilding = _buildingConfig select _currentBuildings;
					_costArray = getArray (_newBuilding >> "cost");
					
					_didBuy = [_costArray,_aiSide,_resourcesSpent] call alk_ai_fnc_didBuy;	
				

					
					if(_didBuy)then{
						_logic setvariable ["alk_fnc_resourcesSpent",_resourcesSpent];
						_spawnPos = if(_aiSide isEqualTo opfor)then{Opfor_spawn;}else{Blufor_spawn;};
						_pos = [_spawnPos, 1, 100, 10, 0, 20, 0] call BIS_fnc_findSafePos;
						

						_args = getArray (_newBuilding >> "args");
						_submenu = getText (_newBuilding >> "submenu");
						_className = _args select 1;
						_pos set [2,0];
						
						_object = createSimpleObject [_className, ATLToASL _pos,true]; 
						_buildings pushBack _object;
						_logic setvariable ["alk_fnc_buildings",_buildings];
						_object setvariable ["_belongsTo",_aiSide];
						_object setvariable ["_type",configname _newBuilding];
						_object setvariable ["_submenu",_submenu];
						
					};
				};
				if(time >= _checkTimer)then{
				
					_currentGroups = count _groups;
					
					if(_currentGroups < 5)then{
						//Buy units code	
						if!(_buildings isEqualTo [])then{
							_buildingSelected = selectRandom _buildings;
							
							_parentType = _buildingSelected getvariable ["_submenu","Rsc_RTS_Main_Units"];
							
							_units = (configproperties [missionConfigFile >> _parentType,"isclass _x"]);
							
							_typeClass = configname selectRandom _units;
							_costArray = getArray (missionConfigFile >> _parentType >> _typeClass >> "cost");

							_didBuy = [_costArray,_aiSide,_resourcesSpent] call alk_ai_fnc_didBuy;
							
							if(_didBuy)then{
								_group = [_aiSide,_typeClass,_buildingSelected] call alk_ai_fnc_createGroup;
								_groups pushBack _group;
								_logic setVariable ["alk_fnc_groups",_groups];
								_logic setVariable ["alk_fnc_checkTimer",time + 45];
							};
						};
						
					};
				};
				//Control units code
				{
					_group = _x;
					if!(_group isEqualTo grpnull)then{
						_currentJob = _group getvariable ["alk_fnc_currentJob",0];
						if(_currentJob isEqualTo 0)then{
						_sideCapturePoints = if(_aiSide isEqualTo opfor)then{_capturePointCloseOpfor;}else{_capturePointCloseBlufor;};
				
						_closesNonCapturedPoint = -1;
						
					
						_closesNonCapturedPoint =	_sideCapturePoints findIf {
							_side = (_x select 1) getvariable ["_belongsTo",civilian]; 
							_groupsCapturing =(_x select 1) getVariable ["groupsCapturing",[]];
							_teamAlreadyCaptureing = _groupsCapturing findIf {side _x isEqualTo _aiSide} >= 0;
							!(_aiSide isEqualTo _side) && !_teamAlreadyCaptureing
						
						};	
						
						if(_closesNonCapturedPoint isEqualTo -1)then{
							_closesNonCapturedPoint =	_sideCapturePoints findIf {
							_side = (_x select 1) getvariable ["_belongsTo",civilian]; 
							
							!(_aiSide isEqualTo _side)
						
							};	
						
						};
						
						
							if(_closesNonCapturedPoint >= 0)then{
								_group setvariable ["alk_fnc_currentJob",1];
								
							
								[(_sideCapturePoints select _closesNonCapturedPoint) select 1,units _group] remoteExec ["Alk_Objective_fnc_capture_server", 2];
							};
						};
						if(_currentJob isEqualTo 1)then{
							_isCapturing = _group getvariable ["isCapturing",false];
							if!(_isCapturing)then{
								_group setvariable ["alk_fnc_currentJob",0];
							};		

						};
					}else{
						_groups deleteAt _forEachIndex;
						_logic setVariable ["alk_fnc_groups",_groups];
					};
				}foreach _groups;
			
			
			
		}foreach _aiUnits;

	};
};