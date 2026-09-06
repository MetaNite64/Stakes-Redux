SMODS.current_mod.calculate = function(self, context)
    -- white stake go to shop after skipping blinds
    if context.skip_blind and not G.GAME.modifiers.srdx_skip_shops and SMODS.Mods.stakesredux.config.pink_stake ~= 3 then
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

    -- BUNCO CROSSMOD
    -- Scattering playing cards
    if context.remove_playing_cards then
        local scattering = 0
        for i, v in pairs(context.removed) do
            if v.ability.bunc_scattering then scattering = scattering + 1 end
        end
        if scattering > 0 then
            local to_destroy = {}
            repeat
                local card = pseudorandom_element(G.playing_cards, "scattering")
                to_destroy[#to_destroy + 1] = (not card.getting_sliced) and card
            until #to_destroy == 2
            SMODS.destroy_cards(to_destroy)
        end
    end

    -- Hindered playing cards
    if context.drawing_cards then
        local extra_discards = 0
        for i, v in ipairs(G.hand.cards) do
            if v.ability.bunc_hindered_discarded and v.ability.bunc_hindered_discarded < G.GAME.current_round.hands_played then
                draw_card(G.hand, G.discard, 1, nil, true, v)
                extra_discards = extra_discards + 1 + v.ability.extra_slots_used - v.ability.card_limit
                v.ability.bunc_hindered_discarded = nil
            end
        end
        return { cards_to_draw = context.amount + extra_discards }
    end
    if context.end_of_round and context.main_eval then
        for i, v in pairs(G.playing_cards) do
            v.ability.bunc_hindered_discarded = nil
        end
    end
end

SMODS.current_mod.set_debuff = function(card)
    if card.ability and card.ability.bunc_reactive then
        local reactive_condition
        for _, v in pairs(G.GAME.round_resets.blind_states) do
            if v == "Skipped" then reactive_condition = true end
        end

        if card.ability.bunc_reactive and not reactive_condition then return true end
    end
end
