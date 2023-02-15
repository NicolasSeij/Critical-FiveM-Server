Config = {}

-------------------------- COMMANDS & FUNCTIONALITY

Config.FeedbackClientCommand = 'report' -- The command that the players use to report something

Config.FeedbackAdminCommand = 'reports' -- The command that the admins use to check the pendent feedbacks list

Config.FeedbackCooldown = 10 -- Time in minutes

-------------------------- ADMIN PERMISSIONS

Config.ESX = true -- Set this to true if you use ESX 

-- If you use ESX you don't need to add any identifier to Config.AdminList because it checks if you have permission by your player group (superadmin, admin, mod)

-- Types of identifiers: steam: | license: | xbl: | live: | discord: | fivem: | ip:
Config.AdminList = {
	'discord:393810933685682178',
	'discord:807367718470549566', 
	'discord:912104442445332501', 
	'discord:451913608805482498', 
	'discord:425060134448922626', 
	'discord:624449998213611541',
	'discord:630190219789991957'	-- Example, change this
}

-------------------------- DISCORD LOGS

-- To set your Discord Webhook URL go to server.lua, line 13

Config.BotName = 'AFTER LIFE' -- Write the desired bot name

Config.ServerName = 'AFTER LIF' -- Write your server's name

Config.IconURL = '' -- Insert your desired image link

Config.DateFormat = '%d/%m/%Y [%X]' -- To change the date format check this website - https://www.lua.org/pil/22.1.html

-- To change a webhook color you need to set the decimal value of a color, you can use this website to do that - https://www.mathsisfun.com/hexadecimal-decimal-colors.html

Config.NewFeedbackWebhookColor = '65352'

Config.AssistFeedbackWebhookColor = '16127'

Config.ConcludeFeedbackWebhookColor = '16711680'

-- ok? okok