/*
	Author: Alkanet, Karel Moricky

	Description:
	Creates a RTS camera view.
	
	Based on Bis_fnc_camera by Karel Moricky. 

	Parameter(s):
	_this select 0: MODE - Mode to use. Default is "Init". - STRING
	_this select 1: PARAMETERS - ARRAY.
		PARAMETERS select 0: DISPLAY - Display to be used. - DISPLAY
		PARAMETERS select 1: CAMERAPOSITION - Position the camera will be created at. - ARRAY, OBJECT
	
	Example:
	_display = findDisplay 46 createDisplay "RscDisplayEmpty";
	_playerPos = positionCameraToWorld [0,0,0];
	["Init",[_display,_playerPos]] call RTSENGINE_Camera_fnc_init;

	Returns:
	NOTHING
*/

#define DIK_ESCAPE          0x01
#define DIK_1               0x02
#define DIK_2               0x03
#define DIK_3               0x04
#define DIK_4               0x05
#define DIK_5               0x06
#define DIK_6               0x07
#define DIK_7               0x08
#define DIK_8               0x09
#define DIK_9               0x0A
#define DIK_0               0x0B
#define DIK_MINUS           0x0C    /* - on main keyboard */
#define DIK_EQUALS          0x0D
#define DIK_BACK            0x0E    /* backspace */
#define DIK_TAB             0x0F
#define DIK_Q               0x10
#define DIK_W               0x11
#define DIK_E               0x12
#define DIK_R               0x13
#define DIK_T               0x14
#define DIK_Y               0x15
#define DIK_U               0x16
#define DIK_I               0x17
#define DIK_O               0x18
#define DIK_P               0x19
#define DIK_LBRACKET        0x1A
#define DIK_RBRACKET        0x1B
#define DIK_RETURN          0x1C    /* Enter on main keyboard */
#define DIK_LCONTROL        0x1D
#define DIK_A               0x1E
#define DIK_S               0x1F
#define DIK_D               0x20
#define DIK_F               0x21
#define DIK_G               0x22
#define DIK_H               0x23
#define DIK_J               0x24
#define DIK_K               0x25
#define DIK_L               0x26
#define DIK_SEMICOLON       0x27
#define DIK_APOSTROPHE      0x28
#define DIK_GRAVE           0x29    /* accent grave */
#define DIK_LSHIFT          0x2A
#define DIK_BACKSLASH       0x2B
#define DIK_Z               0x2C
#define DIK_X               0x2D
#define DIK_C               0x2E
#define DIK_V               0x2F
#define DIK_B               0x30
#define DIK_N               0x31
#define DIK_M               0x32
#define DIK_COMMA           0x33
#define DIK_PERIOD          0x34    /* . on main keyboard */
#define DIK_SLASH           0x35    /* / on main keyboard */
#define DIK_RSHIFT          0x36
#define DIK_MULTIPLY        0x37    /* * on numeric keypad */
#define DIK_LMENU           0x38    /* left Alt */
#define DIK_SPACE           0x39
#define DIK_CAPITAL         0x3A
#define DIK_F1              0x3B
#define DIK_F2              0x3C
#define DIK_F3              0x3D
#define DIK_F4              0x3E
#define DIK_F5              0x3F
#define DIK_F6              0x40
#define DIK_F7              0x41
#define DIK_F8              0x42
#define DIK_F9              0x43
#define DIK_F10             0x44
#define DIK_NUMLOCK         0x45
#define DIK_SCROLL          0x46    /* Scroll Lock */
#define DIK_NUMPAD7         0x47
#define DIK_NUMPAD8         0x48
#define DIK_NUMPAD9         0x49
#define DIK_SUBTRACT        0x4A    /* - on numeric keypad */
#define DIK_NUMPAD4         0x4B
#define DIK_NUMPAD5         0x4C
#define DIK_NUMPAD6         0x4D
#define DIK_ADD             0x4E    /* + on numeric keypad */
#define DIK_NUMPAD1         0x4F
#define DIK_NUMPAD2         0x50
#define DIK_NUMPAD3         0x51
#define DIK_NUMPAD0         0x52
#define DIK_DECIMAL         0x53    /* . on numeric keypad */
#define DIK_OEM_102         0x56    /* < > | on UK/Germany keyboards */
#define DIK_F11             0x57
#define DIK_NUMPADENTER     0x9C    /* Enter on numeric keypad */


disableserialization;
_mode = _this param [0,"Init",[displaynull,""]];
_this = _this param [1,[]];

switch _mode do {

	///////////////////////////////////////////////////////////////////////////////////////////
	case "Init": {
	
		_display = _this select 0;
		_camPos =  _this select 1;
	
		alk_fnc_freeCam_draw3D = addmissioneventhandler ["draw3d","['Draw3D',_this] call RTSENGINE_Camera_fnc_init;"];

		_dir = positionCameraToWorld [0,0,0] getdir positionCameraToWorld [0,0,1];
		_vectorDir = (agltoasl positionCameraToWorld [0,0,0]) vectorFromTo (agltoasl positionCameraToWorld [0,0,1]);
		_vectorDir = [_vectorDir,_dir] call BIS_fnc_rotateVector2D;
		_vectorDirY = _vectorDir select 1;
		if (_vectorDirY == 0) then {_vectorDirY = 0.01;};
		_pitch = atan ((_vectorDir select 2) / _vectorDirY);
		
		//_camPos = positionCameraToWorld [0,0,0];
		_cam = missionnamespace getvariable ["Alk_fnc_freeCam_cam","camera" camcreate _camPos];
		_cam cameraeffect ["internal","back"];
		_cam campreparefov 0.75;
		_cam camcommitprepared 0;
		showcinemaborder false;
		cameraEffectEnableHUD true;
		vehicle cameraon switchcamera cameraview;
		
		_cam setdir _dir;
		[_cam,_pitch,0] call bis_fnc_setpitchbank;

		missionnamespace setvariable ["alk_fnc_freeCam_cam",_cam];
		alk_fnc_freeCam_isOpen = true;
		alk_fnc_freeCam_LMB = false;
		alk_fnc_freeCam_disableInput = false;
		alk_fnc_freeCam_RMB = false;
		alk_fnc_freeCam_keys = [];
		alk_fnc_freeCam_LMBclick = [0,0];
		alk_fnc_freeCam_RMBclick = [0,0];
		alk_fnc_freeCam_pitchbank = [_pitch,0];
		alk_fnc_freeCam_fov = 0.75;
		alk_fnc_freeCam_vision = 0;
		alk_fnc_freeCam_visibleHUD = true;
		alk_fnc_freeCam_cameraView = cameraview;
		alk_fnc_freeCam_cameraLimit = [];
		alk_fnc_freeCam_ClickFunction = {true};
		alk_fnc_freeCam_DragFunction = {true};
		alk_fnc_freeCam_ExitFunction = {true};
		
		if (isNil "alk_fnc_freeCam_CLICKABLEobject") then{
			alk_fnc_freeCam_CLICKABLEobject = [];
		};
		if (isNil "alk_fnc_freeCam_HOVEREDobject") then{
			alk_fnc_freeCam_HOVEREDobject = [];
		};
		if (isNil "alk_fnc_freeCam_SELECTEDobject") then{
			alk_fnc_freeCam_SELECTEDobject = [];
		};

		cameraon switchcamera "internal";

		_DIKcodes = true call bis_fnc_keyCode;
		_DIKlast = _DIKcodes select (count _DIKcodes - 1);
		for "_k" from 0 to (_DIKlast - 1) do {
			alk_fnc_freeCam_keys set [_k,false];
		};

		
		_display displayAddEventHandler ["Unload", {params ["_display", "_exitCode"];['Exit'] call RTSENGINE_Camera_fnc_init;}];
		
		uiNamespace setvariable ["alk_fnc_freeCam_display",_display];
		_mouseArea = _display ctrlCreate ["RscText", 1111];
		_mouseArea ctrladdeventhandler ["keydown","['KeyDown',_this] call RTSENGINE_Camera_fnc_init;"];
		_mouseArea ctrladdeventhandler ["keyup","['KeyUp',_this] call RTSENGINE_Camera_fnc_init;"];
		_mouseArea ctrladdeventhandler ["mousebuttondown","['MouseButtonDown',_this] call RTSENGINE_Camera_fnc_init;"];
		_mouseArea ctrladdeventhandler ["mousebuttonup","['MouseButtonUp',_this] call RTSENGINE_Camera_fnc_init;"];
		_mouseArea ctrladdeventhandler ["mousezchanged","['MouseZChanged',_this] call RTSENGINE_Camera_fnc_init;"];
		
		

		
		_mouseArea ctrlenable true;
		_mouseArea ctrlSetPosition [safezoneX,safezoneY,safezoneW,safezoneH];
		_mouseArea ctrlCommit 0;
		ctrlsetfocus _mouseArea;

		_mouseArea ctrladdeventhandler ["mousemoving","['Mouse',_this] call RTSENGINE_Camera_fnc_init;"];
		_mouseArea ctrladdeventhandler ["mouseholding","['Mouse',_this] call RTSENGINE_Camera_fnc_init;"];
		ctrlsetfocus _mouseArea;
		
		uiNamespace setvariable ["alk_fnc_freeCam_mouseArea",_mouseArea];
	};

	///////////////////////////////////////////////////////////////////////////////////////////
	case "Mouse": {
		_display = ctrlparent (_this select 0);
		_mouseOver = _this select 3;
	
		_cam = missionnamespace getvariable ["alk_fnc_freeCam_cam",objnull];
		_pitchbank = alk_fnc_freeCam_pitchbank;
		_pitch = _pitchbank select 0;
		_bank = _pitchbank select 1;

		//--- Camera movement
		if (alk_fnc_freeCam_LMB || alk_fnc_freeCam_RMB) then {
			_mX = _this select 1;
			_mY = _this select 2;

			if (alk_fnc_freeCam_LMB) then {
				_defX = alk_fnc_freeCam_LMBclick select 0;
				_defY = alk_fnc_freeCam_LMBclick select 1;
			
				if!([_defX,_defY] isEqualTo [_mX,_mY])then{
					[screentoworld getmouseposition] call alk_fnc_freeCam_DragFunction;
				};
				
				
			} else {

				_defX = alk_fnc_freeCam_RMBclick select 0;
				_defY = alk_fnc_freeCam_RMBclick select 1;

				_dX = (_mX - _defX) * 180 * alk_fnc_freeCam_fov;
				_dY = -(_mY - _defY) * 180 * alk_fnc_freeCam_fov;

				if (alk_fnc_freeCam_keys select DIK_LCONTROL) then {
					_bank = (_bank + _dX * 0.1) max -180 min +180;
					alk_fnc_freeCam_pitchbank set [1,_bank];
				} else {
					_cam setdir (direction _cam + _dX);
					_pitch = (_pitch + _dY) max -90 min +90;
				};
				
				[
					_cam,
					_pitch,
					_bank
				] call bis_fnc_setpitchbank;

				alk_fnc_freeCam_RMBclick = [_mX,_defY];
			};

		};

		
		//--- Nelson's solution for key lag
		_camMove = {
			if(!alk_fnc_freeCam_disableInput)then{
				
				
					_dX = _this select 0;
					_dY = _this select 1;
					_dZ = _this select 2;
					_pos = getposasl _cam;
					_dir = (direction _cam) + _dX * 90;
					
					if(_dZ isEqualTo 0 && _dX isEqualTo 0)then{
						_dZ = (vectorDir _cam) select 2;
						if(_dY < 0)then{
							_dZ = _dZ * -1;
						};
					};
				
					_camPos = [
						(_pos select 0) + ((sin _dir) * _coef * _dY),
						(_pos select 1) + ((cos _dir) * _coef * _dY),
						(_pos select 2) + _dZ * _coef
					];
					
					_camPos set [2,(_camPos select 2) max (getterrainheightasl _camPos)];
					
					_camValidated = true;
					
					if!(alk_fnc_freeCam_cameraLimit isEqualTo [])then{
						_camValidated = _camPos inArea alk_fnc_freeCam_cameraLimit;
					};
					
					if(_camValidated)then{
						_cam setposasl _camPos;
					},
				
			};
		};
		_camRotate = {
			if(!alk_fnc_freeCam_disableInput)then{
				_dX = _this select 0;
				_dY = _this select 1;
				_pitchbank = _cam call bis_fnc_getpitchbank;
				_cam setdir (direction _cam + _dX);
				[
					_cam,
					(_pitchbank select 0) + _dY,
					0
				] call bis_fnc_setpitchbank;
			};
		};
		_isActive = {
			{alk_fnc_freeCam_keys select _x} count (actionkeys _this) > 0
		};

		_coef = 0.1;
		if ("cameraMoveTurbo1" call _isActive) then {_coef = _coef * 10;};
		if ("cameraMoveTurbo2" call _isActive) then {_coef = _coef * 100;};
		if (alk_fnc_freeCam_keys select DIK_RSHIFT) then {_coef = _coef / 10;};

		if ("cameraMoveForward" call _isActive) then {[0,1,0] call _camMove;};
		if ("cameraMoveBackward" call _isActive) then {[0,-1,0] call _camMove;};
		if ("cameraMoveLeft" call _isActive) then {[-1,1,0] call _camMove;};
		if ("cameraMoveRight" call _isActive) then {[1,1,0] call _camMove;};

		if ("cameraMoveUp" call _isActive) then {[0,0,1] call _camMove;};
		if ("cameraMoveDown" call _isActive) then {[0,0,-1] call _camMove;};

		if ("cameraLookDown" call _isActive) then {[+0,-1] call _camRotate;};
		if ("cameraLookLeft" call _isActive) then {[-1,+0] call _camRotate;};
		if ("cameraLookRight" call _isActive) then {[+1,+0] call _camRotate;};
		if ("cameraLookUp" call _isActive) then {[+0,+1] call _camRotate;};
		if ("cameraZoomIn" call _isActive) then {
			alk_fnc_freeCam_fov = (alk_fnc_freeCam_fov - 0.01) max 0.01;
			_cam campreparefov alk_fnc_freeCam_fov;
			_cam camcommitprepared 0;
		};
		if ("cameraZoomOut" call _isActive) then {
			alk_fnc_freeCam_fov = (alk_fnc_freeCam_fov + 0.01) min 1;
			_cam campreparefov alk_fnc_freeCam_fov;
			_cam camcommitprepared 0;
		};
	};


	///////////////////////////////////////////////////////////////////////////////////////////
	case "MouseButtonDown": {
		_cam = missionnamespace getvariable ["alk_fnc_freeCam_cam",objnull];
		_button = _this select 1;
		_mX = _this select 2;
		_mY = _this select 3;
		_shift = _this select 4;
		_ctrl = _this select 5;
		_alt = _this select 6;
		
		_mouseArea = uinamespace getvariable ["alk_fnc_freeCam_mouseArea",controlnull];
		ctrlsetfocus _mouseArea;

		if (_button > 0) then {
			alk_fnc_freeCam_RMB = true;
			alk_fnc_freeCam_RMBclick = [_mX,_mY];
		} else {
			alk_fnc_freeCam_LMB = true;
			alk_fnc_freeCam_LMBclick = [_mX,_mY];
		};
		alk_fnc_freeCam_pitchbank set [0,(_cam call bis_fnc_getpitchbank) select 0];
	};

	///////////////////////////////////////////////////////////////////////////////////////////
	case "MouseButtonUp": {
		params ["_displayorcontrol", "_button", "_xPos", "_yPos", "_shift", "_ctrl", "_alt"];
		_cam = missionnamespace getvariable ["alk_fnc_freeCam_cam",objnull];
		_button = _this select 1;
		if (_button > 0) then {
			alk_fnc_freeCam_RMB = false;
			_oldX = alk_fnc_freeCam_RMBclick select 0;
			_oldY = alk_fnc_freeCam_RMBclick select 1;
			if( _oldX isEqualTo _xPos && _oldY isEqualTo _yPos)then{
				
				[_button] call alk_fnc_freeCam_ClickFunction;
			};
			
			alk_fnc_freeCam_RMBclick = [0,0];
		
		} else {
			alk_fnc_freeCam_LMB = false;
			
			_oldX = alk_fnc_freeCam_LMBclick select 0;
			_oldY = alk_fnc_freeCam_LMBclick select 1;
			
			if( _oldX isEqualTo _xPos && _oldY isEqualTo _yPos)then{
				
				[_button] call alk_fnc_freeCam_ClickFunction;

			};
			alk_fnc_freeCam_LMBclick = [0,0];	
		};
		
		alk_fnc_freeCam_pitchbank set [0,(_cam call bis_fnc_getpitchbank) select 0];
	};

	///////////////////////////////////////////////////////////////////////////////////////////
	case "MouseZChanged": {
		_display = _this select 0;
		
			_cam = missionnamespace getvariable ["alk_fnc_freeCam_cam",objnull];
			_camVector = vectordir _cam;

			_dZ = (_this select 1) * 10;
			_vX = (_camVector select 0) * _dZ;
			_vY = (_camVector select 1) * _dZ;
			_vZ = (_camVector select 2) * _dZ;

			_camPos = getposasl _cam;
			_camPos = [
				(_camPos select 0) + _vX,
				(_camPos select 1) + _vY,
				(_camPos select 2) + _vZ
			];
			_camPos set [2,(_camPos select 2) max (getterrainheightasl _camPos)];
			
			_camValidated = true;
					
			if!(alk_fnc_freeCam_cameraLimit isEqualTo [])then{
				_camValidated = _camPos inArea alk_fnc_freeCam_cameraLimit;
			};
			
			if(_camValidated)then{
				_cam setposasl _camPos;
			},
		
	};

	///////////////////////////////////////////////////////////////////////////////////////////
	case "KeyDown": {
		
		_display = _this select 0;
		_key = _this select 1;
		_shift = _this select 2;
		_ctrl = _this select 3;
		_alt = _this select 4;
		_return = false;

		alk_fnc_freeCam_keys set [_key,true];

		_cam = missionnamespace getvariable ["alk_fnc_freeCam_cam",objnull];
		
		switch (true) do {

		
			
			case (_key == DIK_ESCAPE): {

				
				['Exit',_this] call RTSENGINE_Camera_fnc_init;
				alk_fnc_freeCam_RMB = false;
				alk_fnc_freeCam_LMB = false;
				alk_fnc_freeCam_RMBclick = [0,0];
				alk_fnc_freeCam_LMBclick = [0,0];

				_return = true;
			};
			default {};
		};
		_return
	};

	///////////////////////////////////////////////////////////////////////////////////////////
	case "KeyUp": {
		alk_fnc_freeCam_keys set [_this select 1,false];
	};

	///////////////////////////////////////////////////////////////////////////////////////////
	case "Draw3D": {
		
			_cam = missionnamespace getvariable ["alk_fnc_freeCam_cam",objnull];
			
			if!(isNil "alk_fnc_freeCam_specialHover")then{
			
				if!(alk_fnc_freeCam_specialHover isEqualTo objnull)then{
					drawicon3d [
							"\a3\ui_f\data\gui\cfg\hints\commanding_ca.paa",
							[1,0,0,1],
							alk_fnc_freeCam_specialHover,
							1,
							1,
							0,
							"Target",
							2
						];
				};
			};
			
			if!(alk_fnc_freeCam_SELECTEDobject isEqualTo [])then{
				{
					_pos = getPosWorld _x;
					drawicon3d [
							"\a3\ui_f\data\gui\cfg\hints\commanding_ca.paa",
							[1,1,1,1],
							[(_pos select 0),(_pos select 1), 2],
							1,
							1,
							0,
							"",
							1
						];
				}foreach alk_fnc_freeCam_SELECTEDobject;
				_group = group (alk_fnc_freeCam_SELECTEDobject select 0);

				_currentMoveTo = _group getVariable ["doMove",[]];		

				if!(_currentMoveTo isEqualTo [])then{
					drawicon3d [
							"\a3\ui_f\data\gui\cfg\hints\basicmove_ca.paa",
							[1,0,0,1],
							_currentMoveTo,
							1,
							1,
							0,
							"Move to",
							2
						];
				};
				
			
			};
			
			_mousePos = getmouseposition;

			if!(alk_fnc_freeCam_CLICKABLEobject isEqualTo [])then{
				
				_isHovering = false;
				{
					_hoveredObject = _x;
					if (isNull _hoveredObject) then {
					
						alk_fnc_freeCam_CLICKABLEobject deleteAt _forEachIndex;
					
					}else{
						if(_hoveredObject isEqualType grpnull)then{_hoveredObject = leader _hoveredObject;};
						_relPos = _hoveredObject modelToWorld [0,0,4];
						_screenPos = worldToScreen _relPos;
						 
						if!(_screenPos isEqualTo [])then{
						
						
							_name = _hoveredObject getvariable ["_name",""];
							_icon = _hoveredObject getvariable ["alk_fnc_freeCam_click_icon",""];
							 
							
							_pos = getPosWorld _hoveredObject;
							
							if!(_isHovering)then{
								
								if((_mousePos select 0) > (_screenPos select 0) - 0.05 && (_mousePos select 0) < (_screenPos select 0) + 0.05 && (_mousePos select 1) > (_screenPos select 1) - 0.05 && (_mousePos select 1) < (_screenPos select 1) + 0.05)then{
						
									alk_fnc_freeCam_HOVEREDobject = _hoveredObject;
									_isHovering = true;
									drawicon3d [
										"a3\ui_f\data\map\markers\system\empty_ca.paa",
										[1,1,1,1],
										_relPos,
										2,
										2,
										0,
										"",
										2
									];
								};
							};
							
							drawicon3d [
									_icon,
									[1,1,1,1],
									_relPos,
									1,
									1,
									0,
									_name,
									2
								];
						
						};
					
						
					};
				}foreach alk_fnc_freeCam_CLICKABLEobject;
				
				if!(_isHovering)then{
					alk_fnc_freeCam_HOVEREDobject = objnull;				
				};
			};
	};

	


	///////////////////////////////////////////////////////////////////////////////////////////
	case "Exit": {
		if (isNil "alk_fnc_freeCam_draw3D") exitWith{};
	
	
	
		setaperture -1;
		enableradio true;
		showChat true;

		with missionnamespace do {
			_cam = missionnamespace getvariable ["alk_fnc_freeCam_cam",objnull];
			_cam cameraeffect ["terminate","back"];

			

			camdestroy _cam;
			
			alk_fnc_freeCam_cam = nil;
			
		};

		cameraon switchcamera alk_fnc_freeCam_cameraView;

		alk_fnc_freeCam_isOpen = false;
		alk_fnc_freeCam_LMB = nil;
		alk_fnc_freeCam_RMB = nil;
		alk_fnc_freeCam_keys = nil;
		alk_fnc_freeCam_LMBclick = nil;
		alk_fnc_freeCam_RMBclick = nil;
		alk_fnc_freeCam_pitchbank = nil;
		alk_fnc_freeCam_fov = nil;
		
		alk_fnc_freeCam_vision = nil;
		alk_fnc_freeCam_visibleHUD = nil;
		alk_fnc_freeCam_cameraView = nil;

		removemissioneventhandler ["draw3d",alk_fnc_freeCam_draw3D];
		alk_fnc_freeCam_draw3D = nil;

		
		_alk_fnc_freeCam_display = uiNamespace getvariable ["alk_fnc_freeCam_display",displaynull];
		_alk_fnc_freeCam_display closeDisplay 1;
		uiNamespace setvariable ["alk_fnc_freeCam_display",nil];
		
		camusenvg false;
		false SetCamUseTi 0;

		[] call alk_fnc_freeCam_ExitFunction;
	};
};