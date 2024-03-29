/**
 * ExileClient_util_playerEquipment_canAdd
 *
 * Exile Mod
 * www.exilemod.com
 * © 2015 Exile Mod Team
 *
 * This work is licensed under the Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International License. 
 * To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-nd/4.0/.
 */
params ["_player","_itemClassNamePre"];
private _itemClassName = toLower _itemClassNamePre; 
private _itemInformation = [_itemClassName] call BIS_fnc_itemType;
private _itemCategory = _itemInformation select 0;
private _itemType = _itemInformation select 1;
private _canAdd = false;
switch (_itemCategory) do 
{
	case "Weapon":
	{
		private _weaponType = getNumber( configFile >> "CfgWeapons" >> _itemClassName >> "type"); 
		switch (_weaponType) do 
		{
			case 1: 	{ _canAdd = ((primaryWeapon _player) isEqualTo "")}; 
			case 4: 	{ _canAdd = ((secondaryWeapon _player) isEqualTo "")}; 
			case 2: 	{ _canAdd = ((handgunWeapon _player) isEqualTo "")}; 
		};
	};
	case "Equipment":
	{
		switch (_itemType) do
		{
			case "Glasses": 	{ _canAdd = ((goggles _player isEqualTo ""))}; 
			case "Headgear": 	{ _canAdd = ((headgear _player) isEqualTo "")}; 
			case "Vest": 		{ _canAdd = ((vest _player) isEqualTo "")}; 
			case "Uniform": 	{ _canAdd = ((uniform _player) isEqualTo "")}; 
			case "Backpack": 	{ _canAdd = ((backpack _player) isEqualTo "")}; 
		};
	};
	case "Magazine":
	{
		{
			if !((_x select 0) isEqualTo "") then
			{
				if ((_x select 1) isEqualTo []) then
				{
					private _compatibleWeaponItems = (_x select 0) call ExileClient_util_gear_getCompatibleWeaponItems;
					if (_itemClassName in _compatibleWeaponItems) then
					{
						_canAdd = true;
					};
				};
			};
			if (_canAdd) exitWith {};
		}
		forEach 
		[
			[primaryWeapon _player, primaryWeaponMagazine _player], 
			[secondaryWeapon _player, secondaryWeaponMagazine _player], 
			[handgunWeapon _player, handgunMagazine _player] 
		];
	};
	case "Item":
	{
		switch (_itemType) do
		{
			case "AccessoryMuzzle", 
			case "AccessoryPointer", 
			case "AccessorySights", 
			case "AccessoryBipod": 
			{
				private _attachmentSlotIndex = switch (_itemType) do
				{
					case "AccessoryMuzzle": 	{ 0 }; 
					case "AccessoryPointer": 	{ 1 };
					case "AccessorySights": 	{ 2 };
					case "AccessoryBipod": 		{ 3 };
				};
				{
					if !((_x select 0) isEqualTo "") then
					{
						if (((_x select 1) select _attachmentSlotIndex) isEqualTo "") then
						{
							private _compatibleWeaponItems = (_x select 0) call ExileClient_util_gear_getCompatibleWeaponItems;
							if (_itemClassName in _compatibleWeaponItems) then
							{
								_canAdd = true;
							};
						};
					};
					if (_canAdd) exitWith {};
				}
				forEach 
				[
					[primaryWeapon _player, primaryWeaponItems _player], 
					[secondaryWeapon _player, secondaryWeaponItems _player], 
					[handgunWeapon _player, handgunItems _player] 
				];
			};
			case "Watch": 
			{
				if !(("ItemWatch" in (assignedItems player)) || ("Exile_Item_XM8" in (assignedItems player))) then 
				{
					_canAdd = true;
				};
			};
			case "Map",
			case "Radio", 
			case "NVGoggles": 
			{
				if ((hmd _player) isEqualTo "") then
				{
					_canAdd = true;
				};
			}; 
			case "Glasses": 
			{
				if ((goggles _player) isEqualTo "") then
				{
					_canAdd = true;
				};
			};  
			case "Compass": 
			{
				if !(_itemClassName in (assignedItems _player)) then
				{
					_canAdd = true;
				};
			};
			case "GPS":
			{
				if !(("ItemGPS" in (assignedItems _player)) || ("I_UavTerminal" in (assignedItems _player))) then
				{
					_canAdd = true;
				};
			};
			case "UAVTerminal": 
			{
				if !(("ItemGPS" in (assignedItems _player)) || ("I_UavTerminal" in (assignedItems _player))) then
				{
					_canAdd = true;
				};
			};
			case "LaserDesignator", 
			case "Binocular": 
			{
				if ((binocular _player) isEqualTo "") then
				{
					_canAdd = true;
				};
			};
			case "Rangefinder": 
			{
				if !("Rangefinder" in (assignedItems _player)) then
				{
					_canAdd = true;
				};
			};
		};
	};
};
_canAdd
