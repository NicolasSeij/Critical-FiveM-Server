--Script Name: esx_vehicleTeleportPads.
--Description: Teleport vehicles with people, or just people without a vehicle from one location to another location.
--Author: Unknown.
--Modified by: BossManNz.
--Credits: ElPumpo, TheStonedTurtle.

Config              = {}

Config.DrawDistance = 100.0

Config.Marker = {
	Type = 1,
	x = 1.5, y = 1.5, z = 1.0,
	r = 255, g = 55, b = 55
}

Config.Pads = {

	SpaEnter = {
		Text = 'Preciona ~INPUT_CONTEXT~ Para Entrar ~y~Track Day~s~.',
		Marker = { x = 2901.098, y = 4382.215, z = 49.359 },
		TeleportPoint = { x = 4459.912109, y = 7953.455078, z = 78.161133, h = 294.803162 }
	},

	SpaExit = {
		Text = 'Preciona ~INPUT_CONTEXT~ Para Salir ~y~Track Day~s~.',
		Marker = { x = 4459.912109, y = 7953.455078, z = 78.161133 },
		TeleportPoint = { x = 2901.098, y = 4382.215, z = 49.359 }
	}

}