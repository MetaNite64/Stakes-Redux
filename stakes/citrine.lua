SMODS.Stake {
  key = "citrine",
  atlas = "stakes",
  pos = { x = 2, y = 1 },
  applied_stakes = { "sapphire" },
  above_stake = "sapphire",
  colour = G.C.SRDX_CITRINE,
  shiny = true,
  modifiers = function()
    G.GAME.modifiers.enable_rentals_in_shop = true
  end
}
