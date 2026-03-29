SMODS.Stake:take_ownership("red", {
  applied_stakes = { "pink" },
  above_stake = "pink",
  modifiers = function()
    G.GAME.modifiers.srdx_reduced_reward = 1
  end,
})
