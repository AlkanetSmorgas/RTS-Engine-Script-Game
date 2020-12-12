_costArray = _this param [0,[],[[]]];


_didBuy = false;
_validateBuy = true;

for "_i" from 0 to (count _costArray - 1) step 2 do {
	_name = _costArray select _i;
	_value = _costArray select (_i+1);
	_currentValue = [_name] call Alk_Resources_fnc_getValue;
	

	if(_currentValue < _value)then{
		_validateBuy = false;		
	};
};

if(_validateBuy)then{
	_didBuy = true;
		for "_i" from 0 to (count _costArray - 1) step 2 do {
			_name = _costArray select _i;
			_value = _costArray select (_i+1);
			_currentValue = [_name] call Alk_Resources_fnc_getValue;
			_newValue = _currentValue - _value;
			[_name,_newValue] call Alk_Resources_fnc_setValue;
		};
};

_didBuy;