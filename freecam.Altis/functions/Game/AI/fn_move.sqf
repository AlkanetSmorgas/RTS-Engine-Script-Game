_units = _this param [0,[],[[]]];
_pos = _this param [1,[],[[]]];

if (_units isEqualTo []) exitWith{};

_group = group (_units select 0);
_group setVariable ["doMove",_pos];		
aiStopStalk = true;
_units doWatch objNull;	

_group setBehaviour "Safe";

{
//Test this
_x commandWatch objNull;
_x disableAI "SUPPRESSION";
_x disableAI "AUTOCOMBAT";
//End test this


_x doMove _pos;

}foreach _units;
currentMoveTo = _pos;

