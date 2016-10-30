
if not fmmo then fmmo = {} end
if not fmmo.gui then fmmo.gui = {} end

function fmmo.gui.create(player)
    if (player.gui.top.factoriommo_frame ~= nil) then
        player.gui.top.factoriommo_frame.destroy()
    end

    local frame = player.gui.top.add{type="frame", name="factoriommo_frame", caption = "/r/factorio MMO", direction="vertical"}

    local table = frame.add{type="table", name="table", colspan=2}

    table.add{type="label", caption="Local server", style="caption_label_style"}
    -- table.add{type="label", caption= "", name="local_statistics"}
    table.add{type="label", caption= "?", name="local_players"}

    -- table.add{type="label", caption="Players online", style="bold_label_style"}
    -- table.add{type="label", caption= "?", name="local_players"}
    -- table.add{type="label", caption="Science pack 1", style="bold_label_style"}
    -- table.add{type="label", caption= "?", name="local_science_1"}
    -- table.add{type="label", caption="Science pack 2", style="bold_label_style"}
    -- table.add{type="label", caption= "?", name="local_science_2"}
    -- table.add{type="label", caption="Science pack 3", style="bold_label_style"}
    -- table.add{type="label", caption= "?", name="local_science_3"}
    -- table.add{type="label", caption="Alien science", style="bold_label_style"}
    -- table.add{type="label", caption= "?", name="local_alien_science"}
    -- table.add{type="label", caption="Rocket progress", style="bold_label_style"}
    -- table.add{type="label", caption= "?", name="local_rocket_progress"}
    table.add{type="label", caption="Dash Dash", style="bold_label_style"}
    table.add{type="label", caption= "?", name="local_s_module"}
    table.add{type="label", caption="Pinx", style="bold_label_style"}
    table.add{type="label", caption= "?", name="local_p_module"}
    table.add{type="label", caption="Chill Bars", style="bold_label_style"}
    table.add{type="label", caption= "?", name="local_e_module"}


    table.add{type="label", caption="Other server", style="caption_label_style"}
    -- table.add{type="label", caption= "", name="remote_statistics"}
    table.add{type="label", caption= "?", name="remote_players"}

    -- table.add{type="label", caption="Players online", style="bold_label_style"}
    -- table.add{type="label", caption= "?", name="remote_players"}
    -- table.add{type="label", caption="Science pack 1", style="bold_label_style"}
    -- table.add{type="label", caption= "?", name="remote_science_1"}
    -- table.add{type="label", caption="Science pack 2", style="bold_label_style"}
    -- table.add{type="label", caption= "?", name="remote_science_2"}
    -- table.add{type="label", caption="Science pack 3", style="bold_label_style"}
    -- table.add{type="label", caption= "?", name="remote_science_3"}
    -- table.add{type="label", caption="Alien science", style="bold_label_style"}
    -- table.add{type="label", caption= "?", name="remote_alien_science"}
    -- table.add{type="label", caption="Rocket progress", style="bold_label_style"}
    -- table.add{type="label", caption= "?", name="remote_rocket_progress"}
    table.add{type="label", caption="Dash Dash", style="bold_label_style"}
    table.add{type="label", caption= "?", name="remote_s_module"}
    table.add{type="label", caption="Pinx", style="bold_label_style"}
    table.add{type="label", caption= "?", name="remote_p_module"}
    table.add{type="label", caption="Chill Bars", style="bold_label_style"}
    table.add{type="label", caption= "?", name="remote_e_module"}

    table.add{type="label", caption="Time played", style="caption_label_style"}
    table.add{type="label", caption= "?", name="time_played"}
end

function fmmo.gui.update(p, stats)
    if not p.connected then return end
    if (p.index + game.tick) % 60 ~= 0 then return end

    if (p.gui.top.factoriommo_frame == nil) then
      fmmo.gui.create(p)
    end

    local table = p.gui.top.factoriommo_frame.table
    table.time_played.caption = formattime(game.tick)

    table.local_players.caption = global.local_players
    -- table.local_science_1.caption = number_to_readable(stats.local.science_1)
    -- table.local_science_2.caption = number_to_readable(stats.local.science_2)
    -- table.local_science_3.caption = number_to_readable(stats.local.science_3)
    -- table.local_alien_science.caption =  number_to_readable(stats.local.alien_science)
    table.local_s_module.caption =  number_to_readable(stats.loc.s_module)
    table.local_p_module.caption =  number_to_readable(stats.loc.p_module)
    table.local_e_module.caption =  number_to_readable(stats.loc.e_module)
    -- table.local_rocket_progress.caption =  global.local_rocket_progress .. "%"

    table.remote_players.caption = global.remote_players
    -- table.remote_science_1.caption = number_to_readable(stats.remote.science_1)
    -- table.remote_science_2.caption = number_to_readable(stats.remote.science_2)
    -- table.remote_science_3.caption = number_to_readable(stats.remote.science_3)
    -- table.remote_alien_science.caption = number_to_readable(stats.remote.alien_science)
    table.remote_s_module.caption =  number_to_readable(stats.rem.s_module)
    table.remote_p_module.caption =  number_to_readable(stats.rem.p_module)
    table.remote_e_module.caption =  number_to_readable(stats.rem.e_module)
    -- table.remote_rocket_progress.caption =  global.remote_rocket_progress .. "%"

end
