SMODS.Stake {
  key = "platinum",
  prefix_config = { applied_stakes = false, above_stake = false },
  atlas = "stakes",
  pos = { x = 3, y = 0 },
  sticker_atlas = "stickers",
  sticker_pos = { x = 3, y = 1 },
  applied_stakes = { "stake_gold" },
  above_stake = "stake_gold",
  colour = G.C.PLATINUM,
  shiny = true,
  modifiers = function()
    G.GAME.modifiers.srdx_sticker_playing_cards = true
    -- force all stickers on
    G.GAME.modifiers.enable_eternals_in_shop = true
    G.GAME.modifiers.enable_perishables_in_shop = true
    G.GAME.modifiers.enable_rentals_in_shop = true
    for i, v in pairs(SMODS.Stickers) do
      if v.original_mod and v.needs_enable_flag then
        G.GAME.modifiers["enable_" .. i] = true
      end
    end
  end,

  loc_vars = function(self, info_queue, card)
    if SMODS.Mods.stakesredux.config.sticker_stakes == 2 then
      return { key = "stake_srdx_platinum_stickers" }
    end
  end,

  calculate = function(self, context)
    if context.modify_booster_card or context.modify_shop_card then
      local set = context.card.config.center.set
      if set == "Default" or set == "Enhanced" then
        local etper_poll = pseudorandom("etper_playing_card" .. G.GAME.round_resets.ante)
        if etper_poll > 0.7 then context.card:set_eternal(true)
        elseif etper_poll > 0.4 then context.card:set_perishable(true) end
        if pseudorandom("rental_playing_card" .. G.GAME.round_resets.ante) > 0.7 then context.card:set_rental(true) end
        if pseudorandom("gigantic_playing_card" .. G.GAME.round_resets.ante) > 0.85 then context.card:add_sticker("srdx_gigantic", true) end
        if pseudorandom("blighted_playing_card" .. G.GAME.round_resets.ante) > 0.85 then context.card:add_sticker("srdx_blighted", true) end
        if pseudorandom("traitorous_playing_card" .. G.GAME.round_resets.ante) > 0.85 then context.card:add_sticker("srdx_traitorous", true) end
      end
    end
  end
}

-- Eternal: allow playing cards
local set_eternal_ref = Card.set_eternal
Card.set_eternal = function(self, _eternal)
  set_eternal_ref(self, _eternal)
  if (self.config.center.set == "Default" or self.config.center.set == "Enhanced") and not self.ability.perishable then
    self.ability.eternal = _eternal
  end
end

-- Eternal: adjust vanilla content to avoid destroying eternal cards
SMODS.Consumable:take_ownership("hanged_man", {
  can_use = function(self, card)
    if G.hand then
      for i = 1, #G.hand.highlighted do
        if SMODS.is_eternal(G.hand.highlighted[i]) then return false end
      end
      return #G.hand.highlighted > 0 and #G.hand.highlighted <= card.ability.max_highlighted
    end
  end
}, true)

SMODS.Consumable:take_ownership("immolate", {
  use = function(self, card, area)
    local destroyed_cards = {}
    local temp_hand = {}
    for _, v in ipairs(G.hand.cards) do if not SMODS.is_eternal(v) then temp_hand[#temp_hand + 1] = v end end
    table.sort(temp_hand, function(a, b)
      return not a.playing_card or not b.playing_card or a.playing_card < b.playing_card
    end)
    pseudoshuffle(temp_hand, "immolate")
    for i = 1, card.ability.extra.destroy do destroyed_cards[#destroyed_cards + 1] = temp_hand[i] end

    G.E_MANAGER:add_event(Event {
      trigger = "after",
      delay = 0.4,
      func = function()
        play_sound("tarot1")
        card:juice_up(0.3, 0.5)
        return true
      end
    })
    SMODS.destroy_cards(destroyed_cards)

    delay(0.5)
    ease_dollars(card.ability.extra.dollars)
    delay(0.3)
  end
}, true)

SMODS.Joker:take_ownership("trading", {
  name = "srdx_trading_card",
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra } }
  end,
  calculate = function(self, card, context)
    if context.first_hand_drawn and not context.blueprint then
      local eval = function() return G.GAME.current_round.discards_used == 0 and not G.RESET_JIGGLES end
      juice_card_until(card, eval, true)
    end
    if context.discard and not context.blueprint and G.GAME.current_round.discards_used <= 0 and #context.full_hand == 1 then
      return {
        dollars = card.ability.extra,
        delay = 0.45,
        remove = true
      }
    end
  end
}, true)

SMODS.Joker:take_ownership("sixth_sense", {
  name = "srdx_sixth_sense",
  calculate = function(self, card, context)
    if context.destroy_card and not context.blueprint then
      if #context.full_hand == 1 and context.destroy_card == context.full_hand[1] and context.full_hand[1]:get_id() == 6 and G.GAME.current_round.hands_played == 0 then
        if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
          G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
          G.E_MANAGER:add_event(Event {
            func = function()
              SMODS.add_card { set = "Spectral", key_append = "sixth_sense" }
              G.GAME.consumeable_buffer = 0
              return true
            end
          })
          return {
            message = localize("k_plus_spectral"),
            colour = G.C.SECONDARY_SET.Spectral,
            remove = true
          }
        end
      end
    end
  end
}, true)

-- Perishable: allow playing cards
local set_perishable_ref = Card.set_perishable
Card.set_perishable = function(self, _perishable)
  set_perishable_ref(self, _perishable)
  if (self.config.center.set == "Default" or self.config.center.set == "Enhanced") and not self.ability.eternal then
    self.ability.perishable = true
    self.ability.perish_tally = G.GAME.perishable_rounds
  end
end

-- Perishable: don't double-trigger and always calculate on playing cards
local perishable_calc_ref = SMODS.Stickers.perishable.calculate
SMODS.Sticker:take_ownership("perishable", {
  calculate = function(self, card, context)
    if card.config.center.set == "Default" or card.config.center.set == "Enhanced" then
      if context.playing_card_end_of_round then
        card:calculate_perishable()
      end
    else perishable_calc_ref(self, card, context) end
  end
})

-- Rental: don't double-trigger on playing cards held in hand
local rental_calc_ref = SMODS.Stickers.rental.calculate
SMODS.Sticker:take_ownership("rental", {
  calculate = function(self, card, context)
    if card.config.center.set == "Default" or card.config.center.set == "Enhanced" then
      if context.playing_card_end_of_round and context.cardarea == G.hand then
        card:calculate_rental()
      end
    else rental_calc_ref(self, card, context) end
  end
})
