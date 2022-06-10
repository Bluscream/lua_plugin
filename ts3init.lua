--
-- TeamSpeak 3 init
--

-- Global table with all registered modules
-- Module authors should not modify this table directly, use ts3RegisterModule to register your module
ts3RegisteredModules = {}

-- Each Lua module should call ts3RegisterModule once with a unique module name
-- and a table with those TeamSpeak 3 callbacks the module wants to receive.
-- See testmodule/init.lua as an example
function ts3RegisterModule(moduleName, registeredEvents)
	print("Lua loading: " .. moduleName)
	ts3RegisteredModules[moduleName] = registeredEvents
end
