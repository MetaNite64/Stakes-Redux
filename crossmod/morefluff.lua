-- Heavy playing cards
local highlight_ref = Card.highlight
Card.highlight = function(self, is_h, ...)
  local pre = self.highlighted
  local ret = highlight_ref(self, is_h, ...)
  if self.ability.mf_heavy and self.highlighted ~= pre then
    SMODS.change_discard_limit(is_h and -1 or 1)
  end
  return ret
end

local heavy_loc_ref = SMODS.Stickers.mf_heavy.loc_vars
SMODS.Sticker:take_ownership("mf_heavy", {
  loc_vars = function(self, info_queue, card)
    local key = self.key
    if card and (card.config.center.set == "Default" or card.config.center.cet == "Enhanced") and G.STATE ~= G.STATES.MENU then
      key = key .. "_playing"
    end
    local ret = heavy_loc_ref and heavy_loc_ref(self, info_queue, card) or {}
    ret.key = key
    return ret
  end
})

--Potato playing cards
local can_play_ref = G.FUNCS.can_play
G.FUNCS.can_play = function(e)
  local potato_check = false
  for i, v in ipairs(G.hand.cards) do
    if v.ability.mf_potato and not v.highlighted then
      potato_check = true
      break
    end
  end
  if potato_check then
    e.config.colour = G.C.UI.BACKGROUND_INACTIVE
    e.config.button = nil
  else
    return can_play_ref(e)
  end
end

local potato_loc_ref = SMODS.Stickers.mf_potato.loc_vars
SMODS.Sticker:take_ownership("mf_potato", {
  loc_vars = function(self, info_queue, card)
  local key = self.key
  if card and (card.config.center.set == "Default" or card.config.center.cet == "Enhanced") and G.STATE ~= G.STATES.MENU then
    key = key .. "_playing"
    end
    local ret = potato_loc_ref and potato_loc_ref(self, info_queue, card) or {}
    ret.key = key
    return ret
    end
})

-- Suspended playing cards
local bfs_ref = G.FUNCS.buy_from_shop
G.FUNCS.buy_from_shop = function(e)
  local ret = bfs_ref(e)
  local card = e.config.ref_table
  if card and card:is(Card) then
    if (card.ability.set == "Enhanced" or card.ability.set == "Default") and card.ability.mf_suspend_sticker then
      FLUFF.exile_card(card)
      card.ability.mf_suspend_sticker = false
      card.ability.mf_suspended = {
        rounds = 2
      }
    end
  end
  return ret
end

local use_card_ref = G.FUNCS.use_card
G.FUNCS.use_card = function(e)
  local ret = use_card_ref(e)
  local card = e.config.ref_table
  if card and card:is(Card) then
    if (card.ability.set == "Enhanced" or card.ability.set == "Default") and card.ability.mf_suspend_sticker then
      FLUFF.exile_card(card)
      card.ability.mf_suspend_sticker = false
      card.ability.mf_suspended = {
        rounds = 2
      }
    end
  end
  return ret
end

local suspend_loc_ref = SMODS.Stickers.mf_suspend_sticker.loc_vars
SMODS.Sticker:take_ownership("mf_suspend_sticker", {
  loc_vars = function(self, info_queue, card)
  local key = self.key
  if card and (card.config.center.set == "Default" or card.config.center.cet == "Enhanced") and G.STATE ~= G.STATES.MENU then
    key = key .. "_playing"
    end
    local ret = suspend_loc_ref and suspend_loc_ref(self, info_queue, card) or {}
    ret.key = key
    return ret
    end
})
