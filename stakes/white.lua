-- Go to the shop after skipping if white stake is changed
if SMODS.current_mod.config.pink_stake ~= 3 then
  SMODS.current_mod.calculate = function(self, context)
    if context.skip_blind and not G.GAME.modifiers.srdx_skip_shops then
      G.GAME.no_saved = true
      return { func = function()
        G.E_MANAGER:add_event(Event {
          trigger = "after",
          blocking = false,
          func = function()
            G.E_MANAGER:add_event(Event {
              trigger = "after",
              blocking = false,
              func = function()
                if G.STATE ~= G.STATES.SMODS_BOOSTER_OPENED then
                  G.GAME.current_round.reroll_cost = G.GAME.round_resets.reroll_cost
                  G.GAME.current_round.reroll_cost_increase = 0
                  G.STATE = G.STATES.SHOP
                  G.STATE_COMPLETE = false
                  G.GAME.no_saved = nil
                  return true
                end
              end
            })
            if G.blind_select then
              G.blind_select.alignment.offset.y = G.blind_select.alignment.offset.y + G.blind_select.T.h
              G.E_MANAGER:add_event(Event {
                trigger = "after",
                delay = 0.3,
                func = function()
                  G.blind_select:remove()
                  G.blind_prompt_box:remove()
                  return true
                end
              })
            end
            return true
          end
        })
      end}
    end
  end
end

-- apply all the stickers if sticker_stakes is set to apply them on white stake
if SMODS.current_mod.config.sticker_stakes == 4 then
  local gigantic = SMODS.current_mod.config.gigantic_sticker
  SMODS.Stake:take_ownership("white", {
    modifiers = function()
      G.GAME.modifiers.enable_eternals_in_shop = true
      G.GAME.modifiers.enable_perishables_in_shop = true
      G.GAME.modifiers.enable_rentals_in_shop = true
      for i, v in pairs(SMODS.Stickers) do
        if v.original_mod and v.needs_enable_flag then
          G.GAME.modifiers["enable_" .. i] = true
        end
      end
    end
  })
end
