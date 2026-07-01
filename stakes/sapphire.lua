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
  end
}
