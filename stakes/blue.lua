local stake = SMODS.current_mod.config.cyan_stake and "stake_srdx_cyan" or "stake_green"
local stake_loc = SMODS.current_mod.config.cyan_stake and "Cyan" or "Green"

local pre_discard = false

SMODS.Stake:take_ownership("blue", {
  prefix_config = { applied_stakes = false, above_stake = false },
  applied_stakes = { stake },
  above_stake = stake,
  modifiers = function()
    G.GAME.modifiers.srdx_small_discards = true
    G.GAME.modifiers.srdx_currently_discarding = false
  end,
  calculate = function(self, context)
    if context.pre_discard then
      G.GAME.modifiers.srdx_currently_discarding = #context.full_hand
    end
    if context.drawing_cards and G.GAME.modifiers.srdx_currently_discarding then
      local n = G.GAME.modifiers.srdx_currently_discarding - 1
      if #G.hand.cards + n < 1 then n = 1 end
      G.GAME.modifiers.srdx_currently_discarding = false
      return { modify = n }
    end
    if context.hand_drawn then
      G.GAME.modifiers.srdx_currently_discarding = false
    end
  end,
  loc_vars = function(self)
    return { vars = { stake_loc } }
  end
})

local modifies_draw_ref = SMODS.blind_modifies_draw
SMODS.blind_modifies_draw = function(key)
  if G.GAME.modifiers.srdx_small_discards then
    return true
  end
  return modifies_draw_ref(key)
end
