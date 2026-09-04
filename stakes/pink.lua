local above = "stake_white"
if SMODS.current_mod.config.sticker_stakes == 1 then
  above = "stake_srdx_citrine"
  if SMODS.current_mod.config.gigantic_sticker then
    above = "stake_srdx_emerald"
  end
  if SMODS.current_mod.config.blighted_sticker then
    above = "stake_srdx_obsidian"
  end
  if SMODS.current_mod.config.traitorous_sticker then
    above = "stake_srdx_bixbite"
  end
  if next(SMODS.find_mod("MoreFluff")) then
    above = "stake_mf_ultramarine"
  end
end

if SMODS.current_mod.config.pink_stake == 1 then
  SMODS.Stake {
    key = "pink",
    atlas = "stakes",
    pos = { x = 0, y = 0 },
    sticker_atlas = "stickers",
    sticker_pos = { x = 0, y = 1 },
    prefix_config = { applied_stakes = false, above_stake = false },
    applied_stakes = { "stake_white" },
    above_stake = above,
    colour = G.C.SRDX_PINK,
    modifiers = function()
      G.GAME.modifiers.srdx_skip_shops = true
    end
  }
end
