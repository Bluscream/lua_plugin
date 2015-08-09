--
-- Some TeamSpeak 3 functions for testing and demonstration
--

require("ts3defs")
require("ts3errors")

--
-- Call these function from the TeamSpeak 3 client console via: /lua run testmodule.<function>
-- Note the serverConnectionHandlerID of the current server is always passed.
--
-- You might want to pass the "-console" option when starting the TeamSpeak 3 client to get a console where a lot
-- of plugin related debug output will appear.
--

-- Run with "/lua run florian.showClientLibVersion"
function showClientLibVersion(serverConnectionHandlerID)
	local version, error = ts3.getClientLibVersion()
	if error ~= ts3errors.ERROR_ok then
		print("Error getting clientlib version: " .. error)
		return
	end
	ts3.printMessageToCurrentTab("Clientlib version: " .. version)
end

-- Envoie d'informations sur la voix dans le canal
function infoVoice(serverConnectionHandlerID)
	local message = "                                                 [b][color=#3147D7][u]Ce canal est modéré[/u][/color]"
	message = message .. "\n[color=#3147D7][u]Pour obtenir la parole:[/u][/color]"
	message = message .. "\n"
	message = message .. "\n[color=#3147D7]Faites un [color=red]click droit[/color] sur vous, puis clickez sur [color=red]Request Talk Power[/color].[/color]"
	message = message .. "\n[color=#3147D7]Les modérateurs vous donneront la voix dès qu'ils le pourront. Soyez [color=#0BA233][u]patient[/u][/color] avec eux.[/color]"
	message = message .. "\n"
	message = message .. "\n[color=#FF7301][u]Info:[/u][/color]"
	message = message .. "\n[color=#3147D7]Si un modérateur vous enlève la voix pour non respect des règles, il ne sert à rien de refaire une demande ou de 'flooder' le chat. Cela ne fera que retarder votre retour.[/color][/b]"
		
	-- Envoie du message
	ts3.requestSendChannelTextMsg(serverConnectionHandlerID, message, ownChannel, NULL)
	
end

function infoFloodVoice(serverConnectionHandlerID)
	local message = "                                                 [b][color=red][u]A retenir:[/u][/color]"
	message = message .. "\n[color=#3147D7]Flooder le chat pour demander la voix ne vous la fera pas obtenir plus rapidement.[/color][/b]"
		
	-- Envoie du message
	ts3.requestSendChannelTextMsg(serverConnectionHandlerID, message, ownChannel, NULL)
end

function infoTech(serverConnectionHandlerID)
	local message = "                                                 [b][color=#3147D7][u]Comment on fait pour ...[/u][/color]"
	message = message .. "\n\n[color=#FF7301]Avez-vous regardé la description des canaux ?[/color]"
	message = message .. "\n"
	message = message .. "\n[color=#3147D7]Faites un simple click sur le canal [color=red]French Talk 2[/color].[/color]"
	message = message .. "\n[color=#3147D7]Lisez la description, il y a certainement une réponse à votre question.[/color]"
	message = message .. "\n"
	message = message .. "\n[color=#3147D7][u]Si ce n'est pas le cas:[/u][/color]"
	message = message .. "\n[color=#3147D7]N'hésitez pas à demander. Un modérateur ou utilisateur peut certainement vous aider[/color][/b]"
		
	
	-- Envoie du message
	ts3.requestSendChannelTextMsg(serverConnectionHandlerID, message, ownChannel, NULL)
	
end

function startLink()
	kickLink = true
	
	ts3.printMessageToCurrentTab("Kick lien ts3server activé")
end

function stopLink()
	kickLink = false
	
	ts3.printMessageToCurrentTab("Kick lien ts3server désactivé")
end

function startAutoKick()
	autoKickBask = true
	
	ts3.printMessageToCurrentTab("AutoKickBask Activé")
end

function stopAutoKick()
	autoKickBask = false
	
	ts3.printMessageToCurrentTab("AutoKickBask Désactivé")
end

function startPlugin()
	activePlugin = true
	
	ts3.printMessageToCurrentTab("Plugin Activé")
end

function stopPlugin()
	activePlugin = false
	
	ts3.printMessageToCurrentTab("Plugin Désactivé")
end

function status()
	if activePlugin then
		ts3.printMessageToCurrentTab("[b]Statut : Activé[/b]")

		if kickLink then
			ts3.printMessageToCurrentTab("kickLink : Activé")
		else
			ts3.printMessageToCurrentTab("kickLink : Désactivé")
		end
		
		if autoKickBack then
			ts3.printMessageToCurrentTab("AutoKickBack : Activé")
		else
			ts3.printMessageToCurrentTab("AutoKickBack : Désactivé")
		end
	else
		ts3.printMessageToCurrentTab("Statut : Désactivé")
	end
end

function help()
	local message = "--------------------------\n\n"
	message = message .. "[b]startPlugin :[/b] pour activer le plugin (activé automatiquement sur le TS3 public"
	message = message .. "\n[b]stopPlugin :[/b] pour désactiver le plugin"
	message = message .. "\n[b]status :[/b] pour connaitre le statut du plugin"
	message = message .. "\n[b]infoVoice :[/b] pour info parole"
	message = message .. "\n[b]infoTech :[/b] pour info technique"
	message = message .. "\n[b]infoFloodVoice :[/b] pour info flood voice"
	message = message .. "\n[b]startLink :[/b] pour kickchannel sur lien ts3server (par defaut)"
	message = message .. "\n[b]stopLink :[/b] pour un arret du kickchannel sur lien ts3server"
	message = message .. "\n[b]startAutoKick :[/b] active l'autoKickBask"
	message = message .. "\n[b]stopAutoKick :[/b] désactive l'autoKickBask (par defaut)"
	message = message .. "\n[b]help :[/b] affiche ce message"
	message = message .. "\n"
	message = message .. "\n[b]Utilisation :[/b] /lua run <commande>"
	
	ts3.printMessageToCurrentTab(message)
end

public = {
	showClientLibVersion = showClientLibVersion,
	infoVoice = infoVoice,
	infoFloodVoice = infoFloodVoice,
	infoTech = infoTech,
	startLink = startLink,
	stopLink = stopLink,
	stopAutoKick = stopAutoKick,
	startAutoKick = startAutoKick,
	startPlugin = startPlugin,
	stopPlugin = stopPlugin,
	status = status,
	help = help
}