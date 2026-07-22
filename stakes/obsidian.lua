if SMODS.current_mod.config.sticker_stakes == 1 then
  local prev_stake = "citrine"
  local stake_loc = "Citrine"
  if SMODS.current_mod.config.gigantic_sticker then
    prev_stake = "emerald"
    stake_loc = "Emerald"
  end
  SMODS.Stake {
    key = "obsidian",
    atlas = "stakes",
    pos = { x = 4, y = 1 },
    applied_stakes = { prev_stake },
    above_stake = prev_stake,
    colour = G.C.SRDX_OBSIDIAN,
    shiny = true,

    modifiers = function()
      G.GAME.modifiers.enable_srdx_blighted = true
    end,

    loc_vars = function(self, info_queue, card)
      info_queue[#info_queue + 1] = { set = "Other", key = "srdx_blighted", vars = { SMODS.Stickers.srdx_blighted.config.chip_drain } }
      return { vars = { stake_loc } }
    end
  }
end

SMODS.Sticker {
  key = "blighted",
  atlas = "stickers",
  pos = { x = 1, y = 0 },
  badge_colour = G.C.SRDX_OBSIDIAN,
  default_compat = true,
  needs_enable_flag = true,
  rate = 0.15,

  config = {
    chip_drain = 4
  },

  loc_vars = function(self, info_queue, card)
    local key = self.key
    if card and (card.config.center.set == "Default" or card.config.center.set == "Enhanced") and G.STATE ~= G.STATES.MENU then
      key = key .. "_playing"
    end
    return { vars = { card.ability.srdx_blighted.chip_drain }, key = key }
  end,

  calculate = function(self, card, context)
    if context.post_trigger and context.other_card == card then
      local blight = pseudorandom_element(G.playing_cards)
      local visible = false
      if blight.ability.perma_bonus > 3 then
        blight.ability.perma_bonus = blight.ability.perma_bonus - card.ability.srdx_blighted.chip_drain
      elseif blight.ability.perma_bonus > 0 then
        local leftover = card.ability.srdx_blighted.chip_drain - blight.ability.perma_bonus
        blight.ability.perma_bonus = 0
        blight.base.chips = blight.base.chips - leftover
      else
        blight.base.chips = blight.base.chips - card.ability.srdx_blighted.chip_drain
      end

      if blight.base.chips <= 0 then
        SMODS.destroy_cards(blight)
      elseif blight.area == G.hand or blight.area == G.play then
        visible = true
      end
      return {
        message = localize("blighted_trigger"),
        colour = G.C.SRDX_OBSIDIAN,
        message_card = visible and blight or nil
      }
    end

    -- playing card effect
    if context.main_scoring and context.cardarea == G.play then
      if card.ability.perma_bonus > 3 then
        card.ability.perma_bonus = card.ability.perma_bonus - card.ability.srdx_blighted.chip_drain
      elseif card.ability.perma_bonus > 0 then
        local leftover = card.ability.srdx_blighted.chip_drain - card.ability.perma_bonus
        card.ability.perma_bonus = 0
        card.base.chips = card.base.chips - leftover
      else
        card.base.chips = card.base.chips - card.ability.srdx_blighted.chip_drain
      end

      if card.base.chips <= 0 then
        SMODS.destroy_cards(card)
      end
      return {
        message = localize("blighted_trigger"),
        colour = G.C.SRDX_OBSIDIAN
      }
    end
  end
}

-- separate nominal from the card's base chip value
local set_base_ref = Card.set_base
Card.set_base = function(self, card, initial, manual_sprites)
  set_base_ref(self, card, initial, manual_sprites)
  self.base.chips = self.base.nominal
end
