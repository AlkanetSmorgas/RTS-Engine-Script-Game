
// column = 0 row = 2 is hardcoded with back symbol. Can´t be used.

class Rsc_RTS_Main
{
	columns = 4;
	rows = 3;
	
	class Build
	{
		column = 0;
		row = 0;
		image= "\a3\ui_f\data\gui\cfg\respawnroles\support_ca.paa";
		submenu="Rsc_RTS_Main_Buildings";
	};
	
	
};



class Rsc_RTS_Main_Buildings
{
	columns = 4;
	rows = 3;
	
	class Barracks
	{
		column = 0;
		row = 0;	
		image= "\A3\EditorPreviews_F\Data\CfgVehicles\Land_Cargo_HQ_V1_F.jpg";
		args[] = {"Barracks","Land_Cargo_HQ_V1_F",100};
		cost[] = {"Fuel",15};
		function = "Alk_Building_fnc_placeBuilding";
		submenu="Rsc_RTS_Main_Buildings_Barracks_Units";
		returnOnClick = 1;
	};
	
	class Motor
	{
		column = 1;
		row = 0;	
		image= "\A3\EditorPreviews_F\Data\CfgVehicles\Land_TentHangar_V1_F.jpg";
		args[] = {"Motor","Land_TentHangar_V1_F",100};
		cost[] = {"Fuel",50};
		function = "Alk_Building_fnc_placeBuilding";
		submenu="Rsc_RTS_Main_Buildings_Motor_Units";
		returnOnClick = 1;
	};
};

class Rsc_RTS_Main_Buildings_Barracks_Units
{
	columns = 4;
	rows = 3;
	
	class Infantry1
	{
		column = 0;
		row = 0;	
		image = "\A3\EditorPreviews_F\Data\CfgVehicles\B_Soldier_A_F.jpg";
		args[] = {"Infantry1","Rsc_RTS_Main_Buildings_Barracks_Units"};
		cost[] = {"Moral",100};
		function = "Alk_Building_fnc_buyUnits_client";
		returnOnClick = 0;
	};
	class Sniper1
	{
		column = 1;
		row = 0;	
		image = "\A3\EditorPreviews_F\Data\CfgVehicles\B_sniper_F.jpg";
		args[] = {"Sniper1","Rsc_RTS_Main_Buildings_Barracks_Units"};
		cost[] = {"Moral",100,"Ammo",5};
		function = "Alk_Building_fnc_buyUnits_client";
		returnOnClick = 0;
	};
	class AntiTank1
	{
		column = 2;
		row = 0;	
		image = "\A3\EditorPreviews_F\Data\CfgVehicles\B_soldier_AT_F.jpg";
		args[] = {"AntiTank1","Rsc_RTS_Main_Buildings_Barracks_Units"};
		cost[] = {"Moral",100,"Ammo",5};
		function = "Alk_Building_fnc_buyUnits_client";
		returnOnClick = 0;
	};
	
	
};

class Rsc_RTS_Main_Buildings_Motor_Units
{
	columns = 4;
	rows = 3;
	
	class Car1
	{
		column = 0;
		row = 0;	
		image = "\A3\EditorPreviews_F\Data\CfgVehicles\B_MRAP_01_F.jpg";
		args[] = {"Car1","Rsc_RTS_Main_Buildings_Motor_Units"};
		cost[] = {"Moral",100,"Fuel",15};
		function = "Alk_Building_fnc_buyUnits_client";
		returnOnClick = 0;
	};
	class Tank1
	{
		column = 1;
		row = 0;	
		image = "\A3\EditorPreviews_F\Data\CfgVehicles\b_mbt_01_cannon_f.jpg";
		args[] = {"Tank1","Rsc_RTS_Main_Buildings_Motor_Units"};
		cost[] = {"Moral",100,"Fuel",50};
		function = "Alk_Building_fnc_buyUnits_client";
		returnOnClick = 0;
	};
};



class Rsc_RTS_Main_Units
{
	class Infantry1
	{
		submenu="Rsc_RTS_Main_Units_Selected";
		image = "\A3\EditorPreviews_F\Data\CfgVehicles\B_Soldier_A_F.jpg";
		class WEST
		{
			class Unit0
			{
				vehicle="B_soldier_SL_F";
			};
			class Unit1
			{
				vehicle="B_soldier_F";
			};
			class Unit2
			{
				vehicle="B_soldier_F";
			};
			
		};
		class EAST
		{
			class Unit0
			{
				vehicle="O_Soldier_SL_F";
			};
			class Unit1
			{
				vehicle="O_soldier_F";
			};
			class Unit2
			{
				vehicle="O_soldier_F";
			};
			
		};
	};
	class Sniper1
	{
		submenu="Rsc_RTS_Main_Units_Selected";
		image = "\A3\EditorPreviews_F\Data\CfgVehicles\B_sniper_F.jpg";
		class WEST
		{
			class Unit0
			{
				vehicle="B_sniper_F";
			};
			
			
		};
		class EAST
		{
			class Unit0
			{
				vehicle="O_sniper_F";
			};
			
			
		};
	};
	class AntiTank1
	{
		submenu="Rsc_RTS_Main_Units_Selected";
		image = "\A3\EditorPreviews_F\Data\CfgVehicles\B_soldier_AT_F.jpg";
		class WEST
		{
			class Unit0
			{
				vehicle="B_Soldier_AT_F";
			};
			class Unit1
			{
				vehicle="B_Soldier_AT_F";
			};
			
		};
		class EAST
		{
			class Unit0
			{
				vehicle="O_Soldier_AT_F";
			};
			class Unit1
			{
				vehicle="O_Soldier_AT_F";
			};
			
		};
	};
	class Car1
	{
		submenu="";
		image = "\A3\EditorPreviews_F\Data\CfgVehicles\B_MRAP_01_F.jpg";
		class WEST
		{
			class Unit0
			{
				vehicle="B_Soldier_AT_F";
			};
			class Unit1
			{
				vehicle="B_MRAP_01_F";
			};
			
		};
		class EAST
		{
			class Unit0
			{
				vehicle="O_Soldier_AT_F";
			};
			class Unit1
			{
				vehicle="O_MRAP_02_F";
			};
			
		};
	};
	class Tank1
	{
		submenu="";
		image = "\A3\EditorPreviews_F\Data\CfgVehicles\b_mbt_01_cannon_f.jpg";
		class WEST
		{
			class Unit0
			{
				vehicle="B_Soldier_AT_F";
			};
			class Unit1
			{
				vehicle="B_Soldier_AT_F";
			};
			class Unit2
			{
				vehicle="B_Soldier_AT_F";
			};
			class Unit3
			{
				vehicle="B_MBT_01_cannon_F";
			};
			
		};
		class EAST
		{
			class Unit0
			{
				vehicle="O_Soldier_AT_F";
			};
			class Unit1
			{
				vehicle="O_Soldier_AT_F";
			};
			class Unit2
			{
				vehicle="O_Soldier_AT_F";
			};
			class Unit3
			{
				vehicle="O_MBT_02_cannon_F";
			};
			
		};
	};
};


class Rsc_RTS_Main_Units_Selected
{
	columns = 4;
	rows = 3;
	
	class Target
	{
		column = 0;
		row = 0;	
		image= "\a3\ui_f\data\map\markers\military\objective_ca.paa";
		args[] = {};
		function = "Alk_Building_fnc_doTarget";
		returnOnClick = 0;
	};
	class Enter
	{
		column = 1;
		row = 0;	
		image= "\a3\ui_f\data\map\mapcontrol\tourism_ca.paa";
		args[] = {};
		function = "Alk_Building_fnc_enterHouse";
		returnOnClick = 0;
	};
	
};