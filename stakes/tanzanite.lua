SMODS.Stake {
  key = "tanzanite",
  atlas = "stakes",
  pos = { x = 1, y = 0 },
  prefix_config = { applied_stakes = false, above_stake = false },
  applied_stakes = { "stake_white" },
  above_stake = "stake_white",
  colour = G.C.SRDX_TANZANITE,
  shiny = true,
  modifiers = function()
    G.GAME.modifiers.enable_eternals_in_shop = true
  end
}
