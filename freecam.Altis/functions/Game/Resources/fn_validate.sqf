_costArray = _this param [0,[],[[]]];



_validateBuy = true;

for "_i" from 0 to (count _costArray - 1) step 2 do {
	private _name = _costArray select _i;
	private _value = _costArray select (_i+1);
	_currentValue = [_name] call Alk_Resources_fnc_getValue;


	if(_currentValue < _value)then{
		_validateBuy = false;		
	};
};

_validateBuy;