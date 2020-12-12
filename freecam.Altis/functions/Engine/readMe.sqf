/*
\functions\Engine\Camera\fn_init.sqf
This is the file you want to use. Copy it to your scenario folder.
All you need is an display and a position for the rts camera.
The example below will create an rts view. But i recommend to use cfg_functions framework. 
A larger example can be found in functions\Game\Interface\fn_init.sqf (where RTSENGINE_Camera_fnc_init is the file above.)
*/
_display = findDisplay 46 createDisplay "RscDisplayEmpty";
_playerPos = positionCameraToWorld [0,0,0];
["Init",[_display,_playerPos]] spawn compile preprocessFileLineNumbers "\functions\Engine\Camera\fn_init.sqf";




/*
Limit camera movement
You can add a center position, width, height, angle, isRectangle, max height.
Set to empty for no limit. ([])
*/
alk_fnc_freeCam_cameraLimit = [getpos player, 500, 500, 0, false,80];




/*
Add a clickable object.
Object or group is acceptable. If group is used, the leader will be the used. 
You can then add a icon and a name that will be displayed.
*/
_clickableObject = player;
alk_fnc_freeCam_CLICKABLEobject pushBack _clickableObject;
_clickableObject setvariable ["alk_fnc_freeCam_click_icon",""];
_clickableObject setvariable ["_name","Me"];




/*
Click Function
Function to be called when player clicks somewhere on the map. Use it to check if player clicked on the ground or an object.
The variable "alk_fnc_freeCam_HOVEREDobject" contains the object that was clicked. If it´s objnull, the player has clicked on nothing (the ground).
*/
alk_fnc_freeCam_ClickFunction {
params ["_button"];		
	_mousePos = screentoworld getmouseposition;
	//Left click
	if( _button isEqualTo 0) then {
		
		//If an object is clicked on.
		if!(alk_fnc_freeCam_HOVEREDobject isEqualTo objnull)then{
			_building = alk_fnc_freeCam_HOVEREDobject;
		}else{
			//If ground is clicked on. (no object)
			
		};
	
	};
	//Right click
	if( _button isEqualTo 1) then {
	
	
	};
};




/*
DRAG Function
Function to be called when the dragging. (Only works for left click, right click is used for camera rotation.).
*/
alk_fnc_freeCam_DragFunction = {
	params ["_mousePosition"];	
};




/*
EXIT Function
Function to be called after the RTS view is exited. 
A Player can always press escape to exit the view. Do not force the view back instantly, give the player some time.
*/
alk_fnc_freeCam_ExitFunction = {};




/*
Disable camera movement
Set to true for disable.
*/
alk_fnc_freeCam_disableInput = false;




/*
Check if rts view is open. True for open. False if rts view has been exited.
*/
alk_fnc_freeCam_isOpen




/*
Get the camera object
*/
_cam = missionnamespace getvariable ["Alk_fnc_freeCam_cam","camera" camcreate _camPos];




/*
Change the mouse area
Where player can interact with the world. By default its covering the whole screen.
*/
_mouseArea = uinamespace getvariable ["alk_fnc_freeCam_mouseArea",controlnull];
_mouseArea ctrlSetPosition [safezoneX,safezoneY,safezoneW,safezoneH-0.4];
_mouseArea ctrlCommit 0;