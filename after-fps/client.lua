RegisterCommand("fps",function(source,args)
    if args[1] == "on" then
        SetTimecycleModifier("cinema")
        Notificaciones("aumento de fps !")
    elseif args[1] == "off" then
        SetTimecycleModifier("default")
        Notificaciones("aumento de fps apagado!")
    end
end)

function Notificaciones(mensaje)
	SetNotificationTextEntry("STRING")
	AddTextComponentString(mensaje)
	DrawNotification(0,1)
end