require "util"
require "mmo_gui"
require "config"

local stats = require "stats"
local current_event = require "biteoween"

function second_to_tick(seconds)
    return seconds * 60 * game.speed
end

function minute_to_tick(minutes)
    return second_to_tick(minutes*60)
end

function tick_to_second(ticks)
    return math.floor(ticks / 60 / game.speed)
end

function formattime(ticks)
    local seconds = tick_to_second(ticks)
    local days = math.floor(seconds / 86400)
    local remainder = seconds % 86400
    local hours = math.floor(remainder / 3600)
    local remainder = remainder % 3600
    local minutes = math.floor(remainder / 60)
    local seconds = remainder % 60

    if days and days > 0 then
        return string.format("%dd %02d:%02d", days, hours, minutes)
    end
    if hours and hours > 0 then
        return string.format("%d:%02d:%02d", hours, minutes, seconds)
    end
    return string.format("%d:%02d", minutes, seconds)
end

function number_to_readable(num)
    num = tonumber(num)
    if(num) then
      if (num > 10000) then
          return math.floor(num / 1000) .. "k"
      end
      if (num > 1000) then
          return math.floor(num / 1000) .. "." .. math.floor((num % 1000) / 100) .. "k"
      end
      return num
    else
      return " "
    end
end

function get_player_online_count()
    local counter = 0
    for i, x in pairs(game.players) do
        if x.connected then
            counter = counter + 1
        end
    end
    return counter
end

function setup_player_inventory(player)
    local character = player.character

    character.insert{name = "burner-mining-drill", count = 1}
    character.insert{name = "stone-furnace", count = 1}
    character.insert{name = "iron-plate", count = 8}
    character.insert{name = "steel-axe", count = 1}

    character.insert{name = "pistol", count = 1}
    character.insert{name = "firearm-magazine", count = 10}

    current_event.setup_player_inventory(character)
end

script.on_event(defines.events.on_player_created, function(event)
    local player = game.players[event.player_index]

    -- player.minimap_enabled = false
    setup_player_inventory(player)
end)


script.on_event(defines.events.on_tick, function(event)
    local tick = game.tick

    if (global.remaining_until_update < 1) then
        global.remaining_until_update = second_to_tick(10)
        stats = stats.update()
    else
        global.remaining_until_update = global.remaining_until_update - 1
    end

    for k, player in pairs (game.players) do
      fmmo.gui.update(player, stats)
    end
end)


script.on_event(defines.events.on_player_joined_game, function(event)
    local player = game.players[event.player_index]
    print("##FMC::player_joined::" .. player.name)
    global.local_players = get_player_online_count()

    player.print("Welcome to [EU] /r/factorioMMO.")  -- TODO: no test in string there
    player.print("There are currently " .. global.local_players .. " players on this server.")
    --
    player.print("See the stickied post on /r/factorioMMO for rules and more details.")

    call_hook(current_event, 'on_player_joined_game', {player = player, game = game});
end)

script.on_event(defines.events.on_player_left_game, function(event)
    local player = game.players[event.player_index]
    print("##FMC::player_left::" .. player.name)

    global.local_players = get_player_online_count()
end)


script.on_event(defines.events.on_rocket_launched, function(event)
    print("##FMC::rocket_launched")
end)

script.on_event(defines.events.on_built_entity, function(event)
    local player = game.players[event.player_index]
    local item_name = event.created_entity.name
    if (item_name == "rocket-silo") then
        print("##FMC::rocket-silo-built::"..player.name)
        table.insert(global.known_rocket_silos, event.created_entity)
    end
end)

script.on_event(defines.events.on_preplayer_mined_item, function(event)
    local player = game.players[event.player_index]
    local item_name = event.entity.name
    if (item_name == "rocket-silo") then
        print("##FMC::rocket-silo-mined::"..player.name)
        local item_pos = nil
        for i, x in pairs(global.known_rocket_silos) do
            if (x == event.entity) then
                item_pos = i
            end
        end
        if (item_pos ~= nil) then
            table.remove(global.known_rocket_silos, item_pos)
        end
    end
end)


script.on_event(defines.events.on_gui_click, function(event)
    if event.element.name == "factoriommo_dialog_button" then
        local player = game.players[event.player_index]
        local maybegui = player.gui.center['factoriommo_dialog']
        if maybegui then
            maybegui.destroy()
        end
    end
end)

function call_hook(event, namespace, args)
    if(event[namespace]) then
      event[namespace](args)
    end
end



function showdialog(title, message)
    for i, x in pairs(game.players) do
        local maybegui = x.gui.center['factoriommo_dialog']
        if maybegui then
            maybegui.destroy()
        end
        local endgamegui = x.gui.center.add{type="frame", name="factoriommo_dialog", caption=title, direction="vertical"}
        endgamegui.add{type="label", caption=message}
        endgamegui.add{type="button", name="factoriommo_dialog_button", caption="Close this message"}
    end
end


script.on_init(function()
    game.disable_replay()

    stats.init()
    global.remaining_until_update = 0
    global.local_players = 0

    global.remote_players = 0

    global.known_rocket_silos = {}
    global.local_rocket_progress = 0
    global.remote_rocket_progress = 0

    current_event.on_init(game)
end)

remote.add_interface("rconstats", {
    dumpstats = function()
        -- update_stats()
        stats = stats.update()
    end,
    updatestats = function(statname, value)
        if (statname == "player-online-count") then
            global.remote_players = value
            return
        end
        if (statname == "science-pack-1") then
            stats.rem.science_1 = value
            return
        end
        if (statname == "science-pack-2") then
            stats.rem.science_2 = value
            return
        end
        if (statname == "science-pack-3") then
            stats.rem.science_3 = value
            return
        end
        if (statname == "alien-science-pack") then
            stats.rem.alien_science = value
            return
        end
        if (statname == "productivity-module-3") then
            stats.rem.p_module = value
            return
        end
        if (statname == "efficiency-module-3") then
            stats.rem.e_module = value
            return
        end
        if (statname == "speed-module-3") then
            stats.rem.s_module = value
            return
        end
        if (statname == "rocket-progress") then
            global.remote_rocket_progress = value
            return
        end
    end,
    callvictory = function(is_winner)
        if (is_winner) then
            showdialog("You win :D", "You have beaten the other server's team. Well done!")
        else
            showdialog("You lost :(", "You were beaten by the other server's team. Better luck next time.")
        end
    end
})
