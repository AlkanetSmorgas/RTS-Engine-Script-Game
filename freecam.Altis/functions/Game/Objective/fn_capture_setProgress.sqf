_object = _this param [0,objnull,[objnull]];
_progress = _this param [1,0,[0]];
_side = _this param [2,civilian,[civilian]];


_name = _object getVariable ["_name",""];	
			
_formatedText = "";

if(_progress isEqualTo 0)then{
	_formatedText =  format ["%1 is being captured by %2", _name,str _side];
	
}else{


	if(_progress >= 100)then{

		
		_formatedText =  format ["%1 has been captured by %2", _name,str _side];
		_newFlag = "";
		if(_side isEqualTo blufor)then{_newFlag = "flag_NATO";};
		if(_side isEqualTo opfor)then{_newFlag = "flag_CSAT";};
		if(_side isEqualTo civilian)then{_newFlag = "flag_UN";};
		str _object setMarkerTypeLocal _newFlag;
		

	}else{

		_formatedText =  format ["%1 (%2%3)",_name, _progress,"%"];
		
	};



};

_posYfinal = safezoneY - safezoneH;
_display = uiNamespace getvariable ["alk_fnc_freeCam_display",displaynull];

_screenPos = worldToScreen getPos _object;

if( !(_display isEqualTo displaynull) && !(_screenPos isEqualTo []))then{
	_nameCtrl= _display ctrlCreate ["RscText", -1];
	_nameCtrl ctrlSetText _formatedText;
	_nameCtrl ctrlSetFont "EtelkaMonospacePro"; 
	_nameCtrl ctrlSetFontHeight 0.04; 
	_w = ctrlTextWidth _nameCtrl;
	_h = ctrlTextHeight _nameCtrl;		
	_nameCtrl ctrlSetPosition [(_screenPos select 0), (_screenPos select 1), _w, _h];
	_nameCtrl ctrlCommit 0;
	_nameCtrl ctrlSetPositionY _posYfinal;
	_nameCtrl ctrlCommit 9;
	_handle = _nameCtrl spawn {
		sleep 9;
		ctrlDelete _this;
	};
};