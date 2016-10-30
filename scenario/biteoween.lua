
event = {
  config = {}
}


function event.on_init(game)
end

function event.on_player_joined_game(args)
  local player = args.player
  local game = args.game

  player.print(' ')
  player.print('----- Episode I: Prologue -----')
  player.print('Apta Deriva has finally found what\'s going up behind the curtains and has notified your intel team - not without a bite.')
  player.print('The overlords are starting to smuggle with some of the most lucrative drugs from our sector, just as they found a way to smuggle them with ease.')
  player.print('Your corporation has sent a team to produce as many packs as possible to win the favour of the overlords.')
  player.print('Candy packs are made of 1 of each module mk 3. So any excess will not be useful.')
  player.print('The rocket is leaving as the clock hits 4h, taking all the packs that have been produced at the moment.')
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
