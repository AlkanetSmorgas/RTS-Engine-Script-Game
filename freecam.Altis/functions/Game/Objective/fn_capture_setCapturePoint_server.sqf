_nBuilding = _this param [0,objnull,[objnull,[]]];
_pointsToAdd = _this param [1,0,[2]];
_gameTypeCat = _this param [2,1,[1]];
_name = _this param [3,"",[""]];



_nBuilding setvariable ["_pointsToAdd",_pointsToAdd];
_nBuilding setvariable ["_gameTypeCat",_gameTypeCat,true];
_nBuilding setvariable ["_gameType",1,true];
_nBuilding setvariable ["_name",_name,true];

if (isNil "allCapturePoints") then{
	allCapturePoints = [];
};
allCapturePoints pushBack _nBuilding;

[_nBuilding] remoteExec ["Alk_Objective_fnc_capture_setCapturePoint_client", 0]; 
