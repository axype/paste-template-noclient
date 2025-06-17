local process = require("@lune/process")
local stdio = require("@lune/stdio")
local fs = require("@lune/fs")

local isDev = table.find(process.args, "dev") ~= nil
local dluaConfig = isDev and ".darklua.dev.json" or ".darklua.json"

local function cprint(color: stdio.Color, ...)
	stdio.write(stdio.color(color))
	print(...)
	stdio.write(stdio.color("reset"))
end

local function spawnAssert(...)
	local proc = process.spawn(...)

	if not proc.ok then
		error(proc.stderr)
	end

	return proc
end

local function build()
	if not fs.isDir("output") then
		fs.writeDir("output")
	end

	-- Server
	cprint("cyan", "Building server...")
	spawnAssert("darklua", { "process", "-c", dluaConfig, "src/server/init.luau", "output/server.luau" })
	cprint("green", "Built server!")

	-- Rojo
	cprint("white", "Updating Rojo folder...")
	if not fs.isDir("output_rojo") then
		fs.writeDir("output_rojo")
	end

	fs.writeFile("output_rojo/source.luau", `return function(...)\n{fs.readFile("output/server.luau")}\nend`)

	-- Final
	cprint("white", "Paste source is available at ./output/server.luau")
end

build()
