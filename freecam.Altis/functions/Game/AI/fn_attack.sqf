_units = _this param [0,[],[[]]];
_pos = _this param [1,[],[[]]];

if (_units isEqualTo []) exitWith{};

_group = group (_units select 0);
_group setVariable ["doMove",_pos];		
aiStopStalk = true;
_units doWatch objNull;	

_wp =_group addWaypoint [_pos, 0,0];
_wp setWaypointBehaviour "Aware";
_wp setWaypointCombatMode "RED";
_wp setWaypointSpeed "FULL";
_wp setWaypointType "MOVE";				
_group setCurrentWaypoint _wp;


currentMoveTo = _pos;

