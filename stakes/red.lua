local top_sticker_stake = SMODS.current_mod.config.gigantic_sticker and "stake_srdx_emerald" or "stake_srdx_citrine"
local above = SMODS.current_mod.config.sticker_stakes == 1 and top_sticker_stake or "stake_white"
above = SMODS.current_mod.config.pink_stake == 1 and "stake_srdx_pink" or above
local applied = SMODS.current_mod.config.pink_stake == 1 and "stake_srdx_pink" or "stake_white"
local applied_loc = SMODS.current_mod.config.pink_stake == 1 and "Pink" or "White"

SMODS.Stake:take_ownership("red", {
  prefix_config = { applied_stakes = false, above_stake = false },
  applied_stakes = { applied },
  above_stake = above,
  modifiers = function()
    G.GAME.modifiers.srdx_reduced_reward = 1
  end,
  loc_vars = function(self)
    return { vars = { applied_loc } }
  end
})
