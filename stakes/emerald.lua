if SMODS.current_mod.config.sticker_stakes == 1 then
  SMODS.Stake {
    key = "emerald",
    atlas = "stakes",
    pos = { x = 3, y = 1 },
    applied_stakes = { "citrine" },
    above_stake = "citrine",
    colour = G.C.SRDX_EMERALD,
    shiny = true,

    modifiers = function()
      G.GAME.modifiers.enable_srdx_gigantic = true
    end,

    loc_vars = function(self, info_queue, card)
      info_queue[#info_queue + 1] = { set = "Other", key = "srdx_gigantic" }
    end
  }
end

SMODS.Sticker {
  key = "gigantic",
  atlas = "stickers",
  pos = { x = 0, y = 0 },
  badge_colour = G.C.SRDX_EMERALD,
  default_compat = true,
  needs_enable_flag = true,
  rate = 0.15,

  loc_vars = function(self, info_queue, card)
    if card and (card.config.center.set == "Default" or card.config.center.set == "Enhanced") and G.STATE ~= G.STATES.MENU then
      return { key = self.key .. "_playing" }
    end
  end,

  apply = function(self, card, val)
    card.ability[self.key] = val
    card.ability.extra_slots_used = card.ability.extra_slots_used + (val and 1 or -1)
  end
}
