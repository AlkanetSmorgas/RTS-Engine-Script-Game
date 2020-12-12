_type = _this param [0,0,[0,""]];


private _returnvalue = 0;

if(_type isEqualType "")then{

_resourceIndex = resourceData findIf {(_x select 0) isEqualTo _type};

if(_resourceIndex >= 0)then{
	_returnvalue = resourceArrayValue select _resourceIndex;
};

}else{
	_returnvalue = resourceArrayValue select _type;
};


_returnvalue;

