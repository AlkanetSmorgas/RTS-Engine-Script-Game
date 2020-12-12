_clickableObject = _this param [0,objnull,[grpnull,objnull,[]]];
_icon = _this param [1,"",[""]];

if(_clickableObject isEqualType grpnull)then{
	{
		_x setvariable ["alk_fnc_freeCam_click_icon",_icon];
	}foreach units _clickableObject;
}else{
	_clickableObject setvariable ["alk_fnc_freeCam_click_icon",_icon];
};

alk_fnc_freeCam_CLICKABLEobject pushBack _clickableObject;