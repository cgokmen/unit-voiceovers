/*--------------------------------------------------------
Authors: Gokmen, Sceptre
Checks ambient interval / tick time

Parameters:
0: Unit or Group 

Return Value:
<BOOL>
----------------------------------------------------------*/
params ["_item"];

private _interval = _item getVariable ["UVO_ambInterval",(30 + random 60)];
if (CBA_missionTime < _interval) exitWith {false};

true
