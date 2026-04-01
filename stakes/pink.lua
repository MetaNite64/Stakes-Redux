local above = SMODS.current_mod.config.sticker_stakes == 1 and "stake_srdx_emerald" or "stake_white"

if SMODS.current_mod.config.pink_stake == 1 then
  SMODS.Stake {
    key = "pink",
    atlas = "stakes",
    pos = { x = 0, y = 0 },
    sticker_atlas = "stickers",
    sticker_pos = { x = 1, y = 0 },
    prefix_config = { applied_stakes = false, above_stake = false },
    applied_stakes = { "stake_white" },
    above_stake = above,
    colour = G.C.SRDX_PINK,
    modifiers = function()
      G.GAME.modifiers.srdx_skip_shops = true
    end
  }
end
