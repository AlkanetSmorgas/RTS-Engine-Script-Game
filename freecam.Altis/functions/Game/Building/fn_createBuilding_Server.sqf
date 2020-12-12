_type = _this param [0,"",[""]];
_pos = _this param [1,[],[[]]];

_args = getArray (missionConfigFile >> "Rsc_RTS_Main_Buildings" >> _type >> "args");
_className = _args select 1;



_object = createSimpleObject [_className, _pos]; 

_index = allPlayers findIf {owner _x isEqualTo remoteExecutedOwner};


if(_index >= 0)then{
	_player = allPlayers select _index;
	
	_object setvariable ["_belongsTo",side _player];
	_object setvariable ["_type",_type];
};
[_object,_type] remoteExec ["Alk_Building_fnc_createBuilding_Client", remoteExecutedOwner]; 