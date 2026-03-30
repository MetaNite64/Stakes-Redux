SMODS.Stake {
  key = "emerald",
  applied_stakes = { "citrine" },
  above_stake = "citrine",
  colour = G.C.SRDX_EMERALD,
  shiny = true,

  modifiers = function()
    G.GAME.modifiers.enable_srdx_gigantic = true
  end
}

SMODS.Sticker {
  key = "gigantic",
  badge_colour = G.C.SRDX_EMERALD,
  default_compat = true,
  needs_enable_flag = true,
  rate = 0.15,

  loc_vars = function(self, info_queue, card)
    if card and (card.config.center.set == "Default" or card.config.center.set == "Enhanced") then
      return { key = self.key .. "_playing" }
    end
  end,

  apply = function(self, card, val)
    card.ability[self.key] = val
    card.ability.extra_slots_used = card.ability.extra_slots_used + (val and 1 or -1)
  end
}
