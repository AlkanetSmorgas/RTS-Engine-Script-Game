local_losingSide = civilian;
_ticket = getNumber (missionConfigFile >> "RTS_Game" >> "Tickets" >> "defaultValue");

local_losingSideTimer = [_ticket,_ticket];

"TerrorState_TownRaid" cutRsc ["TerrorState_TownRaid","PLAIN",-1,false];

_display = uiNamespace getVariable "TerrorState_TownRaid";
_bluforCtrl = _display displayCtrl 9275;
_bluforCtrl ctrlSetText str _ticket;
_opforCtrl = _display displayCtrl 9276;
_opforCtrl ctrlSetText str _ticket;

while {true} do
{

sleep 1;


{
	_value = _x;
	_index = _forEachIndex;
	
	_perSec = resourceArrayPerSec select _index;
	
	_value = _value + _perSec;
	
	
	[_index,_value] call Alk_Resources_fnc_setValue;
	

}foreach resourceArrayValue;

if!(local_losingSide isEqualTo civilian)then{

	_index = -1;
	if(local_losingSide isEqualTo blufor)then{
		_index = 0;
	};
	if(local_losingSide isEqualTo opfor)then{
		_index = 1;
	};
	
	_currentTime = local_losingSideTimer select _index;
	_currentTime = _currentTime - time;
	
	
	
	if(_currentTime >= 0)then{
		_currentTimestr = _currentTime toFixed 0;
		
		if(local_losingSide isEqualTo blufor)then{
			_bluforCtrl = _display displayCtrl 9275;
			_bluforCtrl ctrlSetText _currentTimestr;
		};
		if(local_losingSide isEqualTo opfor)then{
			_opforCtrl = _display displayCtrl 9276;
			_opforCtrl ctrlSetText _currentTimestr;
		};
	}else{
		if(local_losingSide isEqualTo blufor)then{
			_bluforCtrl = _display displayCtrl 9275;
			_bluforCtrl ctrlSetText "0";
		};
		if(local_losingSide isEqualTo opfor)then{
			_opforCtrl = _display displayCtrl 9276;
			_opforCtrl ctrlSetText "0";
		};
	};
};



};