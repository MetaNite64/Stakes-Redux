SMODS.Stake {
  key = "pink",
  prefix_config = { applied_stakes = false },
  applied_stakes = { "stake_white" },
  above_stake = "citrine",
  colour = G.C.PINK,
  modifiers = function()
    G.GAME.modifiers.srdx_skip_shops = true
  end
}

-- Go to the shop on white stake only
SMODS.current_mod.calculate = function(self, context)
  if context.skip_blind and not G.GAME.modifiers.srdx_skip_shops then
    G.GAME.no_saved = true
    return { func = function()
      G.E_MANAGER:add_event(Event {
        trigger = "after",
        --blocking = false,
        func = function()
          G.E_MANAGER:add_event(Event {
            trigger = "after",
            --blocking = false,
            func = function()
              if G.STATE ~= G.STATES.SMODS_BOOSTER_OPENED then
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
