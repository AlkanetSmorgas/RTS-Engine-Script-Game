_submenuClass = _this param [0,"",[""]];

_alk_fnc_buttomMenu_submenus = uiNamespace getvariable ["alk_fnc_buttomMenu_submenus",[]];

_index = _alk_fnc_buttomMenu_submenus findIf {(_x select 0) isEqualTo _submenuClass};

_parentMenu = uiNamespace getvariable ["alk_fnc_buttomMenu",controlnull];



_alk_fnc_buttomMenu = uiNamespace getvariable ["alk_fnc_buttomMenu_current",controlnull];

_alk_fnc_buttomMenu ctrlEnable false;
_alk_fnc_buttomMenu ctrlShow false;	



if(_index >= 0)then{

	_subMenu = _alk_fnc_buttomMenu_submenus select _index;
	(_subMenu select 1) ctrlEnable true;
	(_subMenu select 1) ctrlShow true;
	uiNamespace setvariable ["alk_fnc_buttomMenu_current",_subMenu select 1];

}else{

	_pos = ctrlPosition _parentMenu;

	_buttomMenuX = _pos select 0;
	_buttomMenuY = _pos select 1;
	_buttomMenuWidth = _pos select 2;
	_buttomMenuHeight = _pos select 3;
	_display = ctrlParent _parentMenu;
	_buttomMenu = _display ctrlCreate ["RscControlsGroupNoScrollbars", -1];
	_buttomMenu ctrlSetPosition [_buttomMenuX,_buttomMenuY,_buttomMenuWidth,_buttomMenuHeight];
	_buttomMenu ctrlSetBackgroundColor [0,0,0,0.5];
	_buttomMenu ctrlCommit 0; 

	_alk_fnc_buttomMenu_submenus pushBack [_submenuClass,_buttomMenu];
	uiNamespace setvariable ["alk_fnc_buttomMenu_submenus",_alk_fnc_buttomMenu_submenus];
	uiNamespace setvariable ["alk_fnc_buttomMenu_current",_buttomMenu];
	
	_columns = getNumber (missionConfigFile >> _submenuClass >> "columns");
	_rows = getNumber (missionConfigFile >> _submenuClass >> "rows");
	
	_btnWidth = _buttomMenuWidth / _columns;
	_btnHeight = _buttomMenuHeight / _rows;

	{
		_btnColumn = getNumber (_x >> "column");
		_btnRow = getNumber (_x >> "row");
		_args = getArray (_x >> "args");
		_function = getText (_x >> "function");
		_returnOnClick = getNumber (_x >> "returnOnClick") > 0;
		_imagePath = getText (_x >> "image");
		_cost = getArray (_x >> "cost");
		
		_btnX = _btnColumn * _btnWidth;
		_btnY = _btnRow * _btnHeight;

		private _ctrlButton = _display ctrlCreate ["DDRscFlowButton", -1, _buttomMenu];
		_ctrlButton setvariable ["RTS_DATA",[_args,_function,_returnOnClick]];
		_ctrlButton ctrlSetPosition [_btnX,_btnY,_btnWidth,_btnHeight];
		
		if!(_imagePath isEqualTo "")then{
			_ctrlButton ctrlsetText _imagePath;
	
		};
		
		_toolTip = configName _x;
		
		if!(_cost isEqualTo [])then{
			_toolTip = _toolTip + "(" + (_cost joinString ":")+ ")";
		};
		
		_ctrlButton ctrlsetTooltip _toolTip;
		_ctrlButton ctrlCommit 0; 
		
		_ctrlButton ctrladdeventhandler ["ButtonClick",{
			params ["_control"];		
				_RTS_DATA = _control getvariable ["RTS_DATA",[]];
				_args = _RTS_DATA select 0;
				_function = missionNamespace getvariable [(_RTS_DATA select 1),{}];
				_returnOnClick = _RTS_DATA select 2;
				 _args spawn _function;
				 
				if(_returnOnClick)then{
					(ctrlParentControlsGroup _control) ctrlEnable false;
					(ctrlParentControlsGroup _control) ctrlShow false;
					_alk_fnc_buttomMenu = uiNamespace getvariable ["alk_fnc_buttomMenu",controlnull];
					_alk_fnc_buttomMenu ctrlEnable true;
					_alk_fnc_buttomMenu ctrlShow true;	
					uiNamespace setvariable ["alk_fnc_buttomMenu_current",_alk_fnc_buttomMenu];
				 };
				
			}];
		
	} foreach (configproperties [missionConfigFile >> _submenuClass,"isclass _x"]);


	_btnX = 0 * _btnWidth;
	_btnY = 2 * _btnHeight;

	private _ctrlButton = _display ctrlCreate ["DDRscFlowButton", -1, _buttomMenu];
	_ctrlButton setvariable ["_ui",_ui];
	_ctrlButton ctrlSetPosition [_btnX,_btnY,_btnWidth,_btnHeight];
	_ctrlButton ctrlSetText "a3\3den\data\controlsgroups\tutorial\back_ca.paa";
	_ctrlButton ctrlCommit 0; 
	
	_ctrlButton ctrladdeventhandler ["ButtonClick",{
		params ["_control"];		
			(ctrlParentControlsGroup _control) ctrlEnable false;
			(ctrlParentControlsGroup _control) ctrlShow false;
			_alk_fnc_buttomMenu = uiNamespace getvariable ["alk_fnc_buttomMenu",controlnull];
			_alk_fnc_buttomMenu ctrlEnable true;
			_alk_fnc_buttomMenu ctrlShow true;	
			uiNamespace setvariable ["alk_fnc_buttomMenu_current",_alk_fnc_buttomMenu];
		}];

};
