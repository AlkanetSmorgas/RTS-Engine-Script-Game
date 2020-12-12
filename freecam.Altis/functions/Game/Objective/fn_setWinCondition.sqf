_currentPoints = _this param [0,[],[[]]];
_side = _this param [1,blufor,[blufor]];
if!(_currentPoints isEqualTo [])then{
	
	_timer1 = time + (_currentPoints select 0);
	_timer2 = time + (_currentPoints select 1);
	local_losingSideTimer = [_timer1,_timer2];
		
		
	local_losingSide = _side;
	
}else{
	
	local_losingSide = civilian;
	
};
