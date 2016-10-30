
event = {
  config = {}
}


function event.on_init(game)
end

function event.on_player_joined_game(args)
  local player = args.player
  local game = args.game
end

function event.setup_player_inventory(character)
  -- Duplicate these
  character.insert{name = "burner-mining-drill", count = 1}
  character.insert{name = "stone-furnace", count = 1}
  character.insert{name = "iron-plate", count = 8}

  character.insert{name = "copper-plate", count = 8}
  character.insert{name = "assembling-machine-1", count = 1}
end

return event;
