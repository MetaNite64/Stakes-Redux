SMODS.Stake {
  key = "tanzanite",
  prefix_config = { applied_stakes = false, above_stake = false },
  applied_stakes = { "stake_white" },
  above_stake = "stake_white",
  colour = G.C.PURPLE,
  modifiers = function()
    G.GAME.modifiers.enable_eternals_in_shop = true
  end
}
