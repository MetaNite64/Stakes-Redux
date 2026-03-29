SMODS.Stake:take_ownership("black", {
  prefix_config = { applied_stakes = false, above_stake = false },
  applied_stakes = { "stake_purple" },
  above_stake = "stake_purple",
  modifiers = function()
    G.GAME.modifiers.scaling = (G.GAME.modifiers.scaling or 1) + 1
  end
})
