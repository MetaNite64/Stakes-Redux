local stake = SMODS.current_mod.config.yellow_stake and "stake_srdx_yellow" or "stake_orange"
local stake_loc = SMODS.current_mod.config.yellow_stake and "Yellow" or "Orange"

SMODS.Stake:take_ownership("green", {
  prefix_config = { applied_stakes = false, above_stake = false },
  applied_stakes = { stake },
  above_stake = stake,
  modifiers = function()
    G.GAME.modifiers.scaling = (G.GAME.modifiers.scaling or 1) + 1
  end,
  loc_vars = function(self)
    return { vars = { stake_loc } }
  end
})
