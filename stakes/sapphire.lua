SMODS.Stake {
  key = "sapphire",
  atlas = "stakes",
  pos = { x = 1, y = 1 },
  applied_stakes = { "tanzanite" },
  above_stake = "tanzanite",
  colour = G.C.SRDX_SAPPHIRE,
  shiny = true,
  modifiers = function()
    G.GAME.modifiers.enable_perishables_in_shop = true
  end,
  loc_vars = function(self, info_queue, card)
    info_queue[#info_queue + 1] = { set = "Other", key = "perishable", vars = { 5, 5 } }
  end
}
