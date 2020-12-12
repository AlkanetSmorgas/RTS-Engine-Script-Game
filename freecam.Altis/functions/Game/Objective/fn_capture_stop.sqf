_object = _this param [0,objnull,[objnull,[]]];
_group = _this param [1,grpnull,[grpnull]];

_group setVariable ["isCapturing",false];

_groupsCapturing =_object getVariable ["groupsCapturing",[]];	
	
_groupsCapturing = _groupsCapturing - [_group];

_object setVariable ["groupsCapturing",_groupsCapturing];		

	