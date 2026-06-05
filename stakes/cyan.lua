SMODS.Stake {
  key = "cyan",
  atlas = "stakes",
  pos = { x = 0, y = 0 },
  sticker_atlas = "stickers",
  sticker_pos = { x = 0, y = 0 },
  prefix_config = { applied_stakes = false, above_stake = false },
  applied_stakes = { "stake_green" },
  above_stake = "stake_green",
  colour = G.C.SRDX_CYAN,
  modifiers = function()
    for i, v in pairs(G.GAME.hands) do
      v.l_chips = v.l_chips * 0.8
      v.l_mult = v.l_mult * 0.8
    end
  end,
}
