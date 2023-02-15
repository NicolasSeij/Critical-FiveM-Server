local blips = {
    -- Example {title="", colour=, id=, x=, y=, z=},

     {title="Pista De Cross", colour=5, id=348, x = 1026.000000, y = 2339.617676, z = 49.583862},
     {title="Autodromo De Galvez", colour=30, id=38, x = 1393.10, y = 3167.51, z = 41.15},
	 {title="Negocio Fort", colour=30, id=475, x = -613.938477, y = -1122.356079, z = 22.320923},
	 {title="Entrada A Nurburing", colour=50, id=595, x = 1284.3297126, y = -3219.876953, z = 8.992676},
	 {title="Entrada A Spa", colour=30, id=595, x = 2901.098, y = 4382.215, z = 49.359 }
	 
  }
       
Citizen.CreateThread(function()

    for _, info in pairs(blips) do
      info.blip = AddBlipForCoord(info.x, info.y, info.z)
      SetBlipSprite(info.blip, info.id)
      SetBlipDisplay(info.blip, 4)
      SetBlipScale(info.blip, 1.0)
      SetBlipColour(info.blip, info.colour)
      SetBlipAsShortRange(info.blip, true)
	  BeginTextCommandSetBlipName("STRING")
      AddTextComponentString(info.title)
      EndTextCommandSetBlipName(info.blip)
    end
end)