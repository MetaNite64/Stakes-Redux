-- Hindered playing cards
local discarding_ref = G.FUNCS.discard_cards_from_highlighted
G.FUNCS.discard_cards_from_highlighted = function(e, hook)
    local highlighted_count = #G.hand.highlighted
    for i, v in ipairs(G.hand.cards) do
        if v.highlighted and v.ability.bunc_hindered then
            v.ability.bunc_hindered_discarded = math.min(v.ability.bunc_hindered_discarded or math.huge, G.GAME.current_round.hands_played)
            G.hand:remove_from_highlighted(v, true)
            highlighted_count = highlighted_count - 1
        end
    end

    if highlighted_count > 0 then
        return discarding_ref(e, hook)
    else
        ease_discard(-1)
        G.GAME.current_round.discards_used = G.GAME.current_round.discards_used + 1
        G.STATE = G.STATES.DRAW_TO_HAND
        G.E_MANAGER:add_event(Event({
            trigger = 'immediate',
            func = function()
                G.STATE_COMPLETE = false
                return true
            end
        }))
    end
end

-- bunco sticker playing card locs
G.E_MANAGER:add_event(Event {
    func = function()
        local scattering_loc_ref = SMODS.Stickers.bunc_scattering.loc_vars
        SMODS.Stickers.bunc_scattering.loc_vars = function(self, info_queue, card)
            local key = self.key
            if card and (card.config.center.set == "Default" or card.config.center.set == "Enhanced") and not card.area.config.collection then
                key = key .. "_playing"
            end
            local ret = scattering_loc_ref and scattering_loc_ref(self, info_queue, card) or {}
            ret.key = key
            return ret
        end

        local hindered_loc_ref = SMODS.Stickers.bunc_hindered.loc_vars
        SMODS.Stickers.bunc_hindered.loc_vars = function(self, info_queue, card)
            local key = self.key
            if card and (card.config.center.set == "Default" or card.config.center.set == "Enhanced") and not card.area.config.collection then
                key = key .. "_playing"
            end
            local ret = hindered_loc_ref and hindered_loc_ref(self, info_queue, card) or {}
            ret.key = key
            return ret
        end
        return true
    end
})
