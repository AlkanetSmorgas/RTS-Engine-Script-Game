_typeOfBuilding = _this param [0,"",[""]];
_className = _this param [1,"",[""]];
_cost = _this param [2,0,[0]];

_buildingAlreadyExits = buildingsArray findIf {_type = _x getvariable ["_type",""];_type isEqualTo _typeOfBuilding};
if(_buildingAlreadyExits >= 0)exitWith{hint "You already bought this buildings";};

_costs = getArray (missionConfigFile >> "Rsc_RTS_Main_Buildings" >> _typeOfBuilding >> "cost");

_hasResources = [_costs] call Alk_Resources_fnc_validate;

if!(_hasResources)exitWith{hint "Not enough resources";};

objectLocal = createSimpleObject [_className, AGLToASL screentoworld getmouseposition,true]; 
objectLocalType = _typeOfBuilding;



_baseCenter = if(side player isEqualTo opfor)then{Opfor_spawn;}else{Blufor_spawn;};



_alk_fnc_freeCam_ClickFunction = {
				
	if( (_this select 0) <= 0) then {
		
		_baseCenter = if(side player isEqualTo opfor)then{Opfor_spawn;}else{Blufor_spawn;};
		
		if(_baseCenter distance2D objectLocal <= 100)then{
			_dimension = (sizeOf typeof objectLocal) * 0.5;

			_nearTerrainObjects = nearestTerrainObjects [objectLocal modelToWorld [0,0,0], ["TREE", "SMALL TREE","TRACK", "BUILDING", "HOUSE", "FOREST BORDER", "FOREST TRIANGLE", "FOREST SQUARE", "CHURCH", "CHAPEL", "CROSS", "BUNKER", "FORTRESS", "FOUNTAIN", "VIEW-TOWER", "LIGHTHOUSE", "QUAY", "FUELSTATION", "HOSPITAL", "FENCE", "WALL", "BUSSTOP", "ROAD", "FOREST", "TRANSMITTER", "STACK", "RUIN", "TOURISM", "WATERTOWER", "MAIN ROAD", "ROCK", "ROCKS", "POWER LINES", "RAILWAY", "POWERSOLAR", "POWERWAVE", "POWERWIND", "SHIPWRECK", "TRAIL"], _dimension];
			
			if(_nearTerrainObjects isEqualTo [])then{
				_pos = getPosasl objectLocal;
				deleteVehicle objectLocal;
				
				_costs = getArray (missionConfigFile >> "Rsc_RTS_Main_Buildings" >> objectLocalType >> "cost");
				_didBuy = [_costs] call Alk_Resources_fnc_buy;
				if(_didBuy)then{
					
					[objectLocalType,_pos] remoteExec ["Alk_Building_fnc_createBuilding_Server", 2]; 
				};
				
				
				objectLocalType = nil;
				[] call Alk_Interface_fnc_resetClickEvent;
			}else{
	
				hint "To close to objects.";
			
			};
		}else{
			hint "To far away from base.";
		};
	
	}else{
		deleteVehicle objectLocal;
		objectLocalType = nil;
		[] call Alk_Interface_fnc_resetClickEvent;
	
	};

};

[_alk_fnc_freeCam_ClickFunction] call Alk_Interface_fnc_setClickEvent;


	
	
while {sleep 0.1;true} do
{
	if(objectLocal isEqualTo objnull)exitWith{};
	if!(alk_fnc_freeCam_isOpen)exitWith{};
	_mousePos = (AGLToASL screentoworld getmouseposition);
	if(_baseCenter distance2D _mousePos <= 100)then{
		objectLocal setPosASL _mousePos;
	};
	
};

if!(alk_fnc_freeCam_isOpen)then{
	deleteVehicle objectLocal;
	objectLocalType = nil;
};

