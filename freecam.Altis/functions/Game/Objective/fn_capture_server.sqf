_object = _this param [0,objnull,[objnull]];
_units = _this param [1,[],[[]]];

if(_units isEqualTo [])exitWith{};

_captureIsBusy =_object getVariable ["captureIsBusy",false];	
_groupsCapturing =_object getVariable ["groupsCapturing",[]];	
	

_group = group (_units select 0);

_doNotExist = _groupsCapturing pushBackUnique _group;

if(_doNotExist >= 0)then{
	_group setVariable ["isCapturing",true];
	[_object,_group] remoteExec ["Alk_Objective_fnc_capture_client", remoteExecutedOwner]; 
};
	
_object setVariable ["groupsCapturing",_groupsCapturing];		

if(_captureIsBusy)exitWith{};

_object setVariable ["captureIsBusy",true];		

_buildingArea = (sizeOf typeof _object);

_completion = 0;

	


_captureingComplete = false;
_startCapture = false;
_winnerGroup = grpnull;
while {true} do
{
	sleep 5;
	_groupsCapturing =_object getVariable ["groupsCapturing",[]];	
	_groupInArea = grpnull;
	{
		_index = units _x findIf {_x distance2D _object <= _buildingArea && alive _x};
		
		if(_index>=0)exitWith{
			_groupInArea = _x;
		};
		
		
		if(_index < 0)then{
			if(unitReady leader _x)then{
			
				_groupsCapturing deleteAt _forEachIndex;
				_x setVariable ["isCapturing",false];
				_object setVariable ["groupsCapturing",_groupsCapturing];
			};
		
		
		};
	
		_groupIsDead = units _x findIf {alive _x} == -1;
		if(_groupIsDead)then{
			_groupsCapturing deleteAt _forEachIndex;
			_x setVariable ["isCapturing",false];
			_object setVariable ["groupsCapturing",_groupsCapturing];
		};
	
		
	}foreach _groupsCapturing;
	
	if!(_groupInArea isEqualTo grpnull)then{
		if(_startCapture)then{
			_completion = _completion + 20;
			[_object,_completion,side _groupInArea] remoteExec ["Alk_Objective_fnc_capture_setProgress", 0]; 
		}else{
			_startCapture = true;
			[_object,_completion,side _groupInArea] remoteExec ["Alk_Objective_fnc_capture_setProgress", 0]; 
		};
		
		
		_winnerGroup = _groupInArea;
	};
	
	if(_groupsCapturing isEqualTo [])exitWith{_captureingComplete = false;};
	if(_completion >= 100)exitWith{_captureingComplete = true;};
	
	
};

if(_captureingComplete)then{
	
	[_object,_winnerGroup] call Alk_Objective_fnc_capture_setOwner;

};
_groupsCapturing =_object getVariable ["groupsCapturing",[]];
{_x setVariable ["isCapturing",false];}foreach _groupsCapturing;

_object setVariable ["captureIsBusy",false];
_object setVariable ["groupsCapturing",[]];		

