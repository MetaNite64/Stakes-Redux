SMODS.Stake:take_ownership("purple", {
  prefix_config = { applied_stakes = false, above_stake = false },
  applied_stakes = { "stake_blue" },
  above_stake = "stake_blue",
  modifiers = function()
    G.GAME.modifiers.srdx_double_showdowns = true
  end,
})
