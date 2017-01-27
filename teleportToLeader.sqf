// this addAction ["<t color='#0099FF'>Teleport to Your Leader Position</t>","scripts\teleportToLeader.sqf"];

/*
0 - Private
1 - Corporal
2 - Sergeant
3 - Lieutenant
4 - Captain
5 - Major
6 - Colonel
*/

#define LEADER_CLASS 3

if  !(local player) exitwith {};

Teleport_to_Ground = {
	[_this select 0, _this select 1] spawn {
		_player = _this select 0;
		_target = _this select 1;
		_dir = getdir _target;

		hint "Teleport to Your Leader Position";
		sleep 1;
		titletext ["","BLACK IN",2];
		vehicle _player setpos [(getpos _target select 0) - ((random(5)+3)*sin(_dir)), (getpos _target select 1) - ((random(5)+3)*cos(_dir)), 0.5];
		vehicle _player setdir ((_dir) -180);

		_player allowDamage false;
		sleep 10;
		_player allowDamage true;
	};
};


Teleport_to_vehicle = {
	[_this select 0, _this select 1] spawn {
		_player = _this select 0;
		_target = _this select 1;
		_dir = getdir _target;

		if ((vehicle _target) emptypositions "cargo"== 0) then
		{
			hint "Your Leader is moving on vehicle and Full of passenger.";
		}
		else
		{
			hint "Teleport to Your Leader Position";
			sleep 1;
			titletext ["","BLACK IN",2];
			vehicle _player moveincargo vehicle _target;
		};
	};
};


{
	_player = _this select 1;
	_target = _x;
	_Prank = rankId _target;

	if (rankId _player == LEADER_CLASS) then
	{
		hint "You can't do this because You are Leader";
	}
	else
	{
		if ((alive vehicle _target) or (alive _target)) then
		{
			if ((_Prank == LEADER_CLASS) && (side _player == side _target)) then
			{
				if ((vehicle _target) == (_target)) then
				{
					[_player,_target] call Teleport_to_Ground;
				}
				else
				{
					[_player,_target] call Teleport_to_vehicle;
				};
			};

		}
		else
		{
			hint "You can't do this because your leader is dead";
		};
	};
} forEach allplayers;