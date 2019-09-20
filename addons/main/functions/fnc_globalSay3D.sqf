/*--------------------------------------------------------
UVO_fnc_globalSay3D
Authors: Gökmen, Sceptre

Globally executes say3D with lip movement functionality

Parameters:
0: Talking unit <OBJECT>
1: Sound class <STRING>

Public:
No

Return Value:
Nothing
----------------------------------------------------------*/
params ["_unit","_sound"];

if (isNil "_sound" || {!alive _unit || _unit getVariable ["ACE_isUnconscious",false] || {behaviour _unit == "STEALTH"}}) exitWith {};

// Don't let the unit talk over himself
if (_unit getVariable ["UVO_talking",false] || inputAction "pushToTalk" > 0) exitWith {};
_unit setVariable ["UVO_talking",true];

[_unit,[_sound,UVO_option_maxDistVoices,UVO_option_soundsSamplePitch,false]] remoteExec ["say3D",0];

// Give some lip movement and let the unit talk again
[_unit,true] remoteExec ["setRandomLip",0];
[{
	[_this,false] remoteExec ["setRandomLip",0];
	_this setVariable ["UVO_talking",false];
},_unit,1.5] call CBA_fnc_waitAndExecute;
