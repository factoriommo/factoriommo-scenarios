local config = require("config")

local stats = {
  loc = {},
  rem = {}
}

function stats.update()

  -- global.local_science_1 = game.forces['player'].item_production_statistics.get_output_count('science-pack-1')
  -- global.local_science_2 = game.forces['player'].item_production_statistics.get_output_count('science-pack-2')
  -- global.local_science_3 = game.forces['player'].item_production_statistics.get_output_count('science-pack-3')
  -- global.local_alien_science = game.forces['player'].item_production_statistics.get_output_count('alien-science-pack')
  stats.loc.p_module = game.forces['player'].item_production_statistics.get_input_count('productivity-module-3')
  stats.loc.e_module = game.forces['player'].item_production_statistics.get_input_count('effectivity-module-3')
  stats.loc.s_module = game.forces['player'].item_production_statistics.get_input_count('speed-module-3')

  -- local highest_rocket_progress = 0
  -- for i, item in pairs(global.known_rocket_silos) do
  --     local progress = item.rocket_parts
  --     if (progress > highest_rocket_progress) then
  --         highest_rocket_progress = progress
  --     end
  -- end
  -- global.local_rocket_progress = highest_rocket_progress

  print("##FMC::player-count::" .. #game.players)
  -- print("##FMC::player-online-count::" .. global.local_players)
  -- print("##FMC::science-pack-1::" .. global.local_science_1)
  -- print("##FMC::science-pack-2::" .. global.local_science_2)
  -- print("##FMC::science-pack-3::" .. global.local_science_3)
  -- print("##FMC::alien-science-pack::" .. global.local_alien_science)
  print("##FMC::productivity-module-3::" .. stats.loc.p_module)
  print("##FMC::efficiency-module-3::" .. stats.loc.e_module)
  print("##FMC::speed-module-3::" .. stats.loc.s_module)
  -- print("##FMC::rocket-progress::" .. global.local_rocket_progress)

  return stats
end

function stats.init()
  stats.loc = {
    p_module = 0,
    e_module = 0,
    s_module = 0
  }
  stats.rem = {
    p_module = 0,
    e_module = 0,
    s_module = 0
  }
end

return stats
