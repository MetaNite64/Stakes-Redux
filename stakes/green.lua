SMODS.Stake:take_ownership("green", {
  applied_stakes = { "yellow" },
  above_stake = "yellow",
  modifiers = function()
    G.GAME.modifiers.scaling = (G.GAME.modifiers.scaling or 1) + 1
  end,
})
