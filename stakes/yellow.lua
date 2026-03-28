SMODS.Stake {
  key = "yellow",
  prefix_config = { applied_stakes = false, above_stake = false },
  applied_stakes = { "stake_orange" },
  above_stake = "stake_orange",
  pos = { x = 2, y = 1 },
  sticker_pos = { x = 3, y = 1 },
  colour = G.C.YELLOW,
  modifiers = function()
    G.GAME.modifiers.scaling = (G.GAME.modifiers.scaling or 1) + 1
  end
}
