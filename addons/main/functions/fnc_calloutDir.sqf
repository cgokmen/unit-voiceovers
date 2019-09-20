/*--------------------------------------------------------
UVO_fnc_calloutDir
Authors: Gökmen, Sceptre

Calls directional phrases

Parameters:
0: Unit that initiates callout (player) <OBJECT>

Public:
No

Return Value:
Nothing
----------------------------------------------------------*/
params ["_unit"];

if (isPlayer _unit && !UVO_option_clientEnabled) exitWith {};

_unit reveal cursorObject;
private _target = cursorTarget;

// Prevent spam
if (diag_tickTime < (_unit getVariable ["UVO_lastCalloutTime",0]) + 2) exitWith {};

if (!alive _target || {(side _unit) getFriend (side _target) >= 0.6}) exitWith {};

// Stop if unit is not alive/unconscious OR doesnt have compass
if (!alive _unit || (_unit getVariable ["ACE_isUnconscious",false]) || {!("ItemCompass" in (assignedItems _unit))}) exitWith {};

// Stop if unit is inside a vehicle, except if its a static weapon
if (!(_unit in _unit) && {!((objectParent _unit) isKindOf "StaticWeapon")}) exitWith {};

// Stop if unit is using launcher
if (currentWeapon _unit == secondaryWeapon _unit) exitWith {};

// Determine callout direction
private _azimuth = getDir _unit;
private _calloutDir = switch (true) do {
	case (_azimuth < 17) : {0};
	case (_azimuth < 73) : {1};
	case (_azimuth < 107) : {2};
	case (_azimuth < 163) : {3};
	case (_azimuth < 197) : {4};
	case (_azimuth < 253) : {5};
	case (_azimuth < 287) : {6};
	case (_azimuth < 343) : {7};
	default {0};
};

_unit setVariable ["UVO_lastCalloutTime",diag_tickTime];
private _nationality = _unit getVariable "UVO_nationality";
[_unit,selectRandom ((missionNamespace getVariable format["UVO_callouts_%1",_nationality]) # _calloutDir)] call FUNC(globalSay3D);
