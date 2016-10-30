
event = {
  config = {}
}

function event.on_init(game)
end

function event.on_player_joined_game(args)
  local player = args.player
  local game = args.game

  showdialogA(player, "Episode I: Prologue", {
    'Apta Deriva has finally found what\'s going up behind the curtains and has notified your intel team - not without a bite.',
    'The overlords are starting to smuggle with some of the most lucrative drugs from our sector, just as they found a way to smuggle them with ease.',
    'Your corporation has sent a team to produce as many packs as possible to win the favour of the overlords.',
    'Candy packs are made of 1 of each module mk 3. So any excess will not be useful.',
    'The rocket is leaving as the clock hits 4h, taking all the packs that have been produced at the moment.'
  })
end

function event.setup_player_inventory(character)
  -- Duplicate these
  character.insert{name = "burner-mining-drill", count = 1}
  character.insert{name = "stone-furnace", count = 1}
  character.insert{name = "iron-plate", count = 8}

  character.insert{name = "copper-plate", count = 8}
  character.insert{name = "assembling-machine-1", count = 1}
end

function showdialogA(player, title, messages)
    local maybegui = player.gui.center['fmmo_init']
    if maybegui then
        maybegui.destroy()
    end
    local frame = player.gui.center.add{type="frame", name="fmmo_init", caption=title, direction="vertical"}
    local table = frame.add{type="table", name="table", colspan=1}
    for i, m in ipairs(messages) do
      table.add{type="label", caption=m}
    end
    table.add{type="button", name="factoriommo_dialog_button", caption="Ready to do this"}
end


return event;
