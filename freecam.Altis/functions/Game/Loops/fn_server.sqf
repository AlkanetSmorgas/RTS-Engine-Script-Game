losingSide = civilian;

_ticket = getNumber (missionConfigFile >> "RTS_Game" >> "Tickets" >> "defaultValue");

losingSidePoints = [_ticket,_ticket];
losingSideTimer = [0,0];
while {true} do
{
_timestampStartOfMainLoop = time;

sleep 1;

_timestampEndOfMainLoop = time;

AAS_MissionTime = AAS_MissionTime + (_timestampEndOfMainLoop - _timestampStartOfMainLoop);
//publicVariable "AAS_MissionTime﻿";

{
	_currentIndex = _forEachIndex;
	_currentResourceArray = _x;
	
	{
		_value = _x;
		_index = _forEachIndex;
		
		_perSec = resourceArrayServerPerSec select _currentIndex;
		
		_value = _value + (_perSec select _index);
		
		_currentResourceArray set [_index,_value];
		
	}foreach _x;
	

}foreach resourceArrayServer;

if!(losingSide isEqualTo civilian)then{
	_index = -1;
	if(losingSide isEqualTo blufor)then{
		_index = 0;
	};
	if(losingSide isEqualTo opfor)then{
		_index = 1;
	};
	_currentTime = losingSidePoints select _index;
	_currentTime = _currentTime - 1;
	losingSidePoints set [_index,_currentTime];
	
	
	
	if(_currentTime isEqualTo 50)then{
		[losingSidePoints,losingSide] remoteExec ["Alk_Objective_fnc_setWinCondition", 0];
	};
	
	if(_currentTime < 0)then{
		
		if(losingSide isEqualTo blufor)then{
			["END1",true] remoteExec ["BIS_fnc_endMission", opfor]; 
			["END1",false] remoteExec ["BIS_fnc_endMission", blufor]; 
		};
		if(losingSide isEqualTo opfor)then{
			["END1",true] remoteExec ["BIS_fnc_endMission", blufor]; 
			["END1",false] remoteExec ["BIS_fnc_endMission", opfor]; 
		};
		losingSide = civilian;
	};
};


//hintSilent parseText ("<t size='2.0'>Resources</t><br/><t size='1.0'>"+str resourceArrayServer+"</t><br/><t size='2.0'>Per sec</t><br/><t size='1.0'>"+str resourceArrayServerPerSec+"</t><br/>");


};