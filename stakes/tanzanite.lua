SMODS.Stake {
  key = "tanzanite",
  atlas = "stakes",
  pos = { x = 0, y = 1 },
  prefix_config = { applied_stakes = false, above_stake = false },
  applied_stakes = { "stake_white" },
  above_stake = "stake_white",
  colour = G.C.SRDX_TANZANITE,
  shiny = true,
  modifiers = function()
    G.GAME.modifiers.enable_eternals_in_shop = true
  end,
  loc_vars = function(self, info_queue, card)
    info_queue[#info_queue + 1] = { set = "Other", key = "eternal" }
  end,
}
