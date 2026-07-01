if SMODS.current_mod.config.sticker_stakes == 1 then
  local prev_stake = "citrine"
  local stake_loc = "Citrine"
  if SMODS.current_mod.config.gigantic_sticker then
    prev_stake = "emerald"
    stake_loc = "Emerald"
  end
  if SMODS.current_mod.config.blighted_sticker then
    prev_stake = "obsidian"
    stake_loc = "Obsidian"
  end
  SMODS.Stake {
    key = "bixbite",
    atlas = "stakes",
    pos = { x = 5, y = 1 },
    applied_stakes = { prev_stake },
    above_stake = prev_stake,
    colour = G.C.SRDX_BIXBITE,
    shiny = true,

    modifiers = function()
      G.GAME.modifiers.enable_srdx_traitorous = true
    end,

    loc_vars = function(self, info_queue, card)
      info_queue[#info_queue + 1] = { set = "Other", key = "srdx_traitorous", vars = { SMODS.Stickers.srdx_traitorous.config.xblindsize } }
      return { vars = { stake_loc } }
    end
  }
end

SMODS.Sticker {
  key = "traitorous",
  atlas = "stickers",
  pos = { x = 2, y = 0 },
  badge_colour = G.C.SRDX_BIXBITE,
  default_compat = true,
  needs_enable_flag = true,
  rate = 0.15,
  config = { xblindsize = 0.2 },

  loc_vars = function(self, info_queue, card)
    local key = self.key
    if card and (card.config.center.set == "Default" or card.config.center.set == "Enhanced") then
      key = key .. "_playing"
    end
    return { vars = { card.ability.srdx_traitorous.xblindsize }, key = key }
  end,

  calculate = function(self, card, context)
    if context.after and (context.cardarea == G.jokers or context.cardarea == G.play) then
      return {
        xblindsize = 1 + #G.hand.cards * card.ability.srdx_traitorous.xblindsize
      }
    end
  end
}
