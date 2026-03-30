SMODS.Stake {
  key = "sapphire",
  atlas = "stakes",
  pos = { x = 2, y = 0 },
  applied_stakes = { "tanzanite" },
  above_stake = "tanzanite",
  colour = G.C.SRDX_SAPPHIRE,
  shiny = true,
  modifiers = function()
    G.GAME.modifiers.enable_perishables_in_shop = true
  end
}
