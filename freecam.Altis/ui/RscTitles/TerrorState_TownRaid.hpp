

class TerrorState_TownRaid
{    
	idd = -1;
	duration = 99999;
	fadein = 1;
	fadeout = 1;
	onLoad = "uiNamespace setVariable ['TerrorState_TownRaid', _this select 0]";
	class controls
	{
		class background 
		{
			idc = -1;
			x = safeZoneX + safezoneW/3;
			y = safeZoneY + 0.05;
			h = 0.08;
			w = safezoneW/3;

			colorBackground[] = {0,0,0,0.2};
			
			font = "EtelkaNarrowMediumPro";
			colorText[] = {1,1,1,1}; 
			sizeEx = safezoneW / 40;
			type = 0;
			style = 80;
			text="";
		};
		class bluforText
		{    
			idc = -1;
			type = 0;
			style = 0; 
			x = safeZoneX + safezoneW/3;
			y = safeZoneY + 0.05;
			h = 0.08;
			w = (safezoneW/3) / 4;
			font = "PuristaLight";
			sizeEx = 0.06;
			colorBackground[] = {0,0,0,0}; 
			colorText[] = {1,1,1,1}; 
			text = "Blufor";
		}; 
		class bluforTimeLeft : bluforText
		{    
			idc = 9275;
			x = (safeZoneX + safezoneW/3) + (((safezoneW/3) / 4) * 1); 
			text = "0";
		}; 
		
		class opforText : bluforText
		{    
			idc = -1;
			x = (safeZoneX + safezoneW/3) + (((safezoneW/3) / 4) * 2); 
			text = "Opfor";
		}; 	
		
		class opforTimeLeft : bluforText
		{    
			idc = 9276;
			x = (safeZoneX + safezoneW/3) + (((safezoneW/3) / 4) * 3); 
			text = "0";
		}; 	
		
	
		
	};	
};