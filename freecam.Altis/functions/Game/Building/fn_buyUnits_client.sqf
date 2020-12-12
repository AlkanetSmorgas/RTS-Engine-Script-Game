_typeClass = _this param [0,"",[""]];
_parentType = _this param [1,"",[""]];

_costs = getArray (missionConfigFile >> _parentType >> _typeClass >> "cost");

_currentGroups = count allUnitsControls;
			
if(_currentGroups < 5)then{

	_didBuy = [_costs] call Alk_Resources_fnc_buy;
	if(_didBuy)then{
		[player,_typeClass,alk_fnc_freeCam_SELECTEDbuilding] remoteExec ["Alk_Building_fnc_buyUnits_server", 2]; 
	}else{
		hint "Not enough resources.";
	};

}else{
	hint "Max groups.";
};